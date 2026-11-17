<#
 Arcade Ice Hockey - Windows desktop wallpaper launcher (no extra software needed).
 Runs ../index.html in a borderless Microsoft Edge window and pins it behind your desktop icons.

 Usage (from this folder):
   powershell -ExecutionPolicy Bypass -File hockey-wallpaper.ps1            # start
   powershell -ExecutionPolicy Bypass -File hockey-wallpaper.ps1 -Stop      # stop
   ... -InstallStartup / -RemoveStartup                                     # run at login
 Options: -Fps 30  -Diff rookie|pro|allstar  -Goals 7  -NoHud
#>
param(
  [int]$Fps = 60,
  [ValidateSet('rookie','pro','allstar')][string]$Diff = 'pro',
  [int]$Goals = 5,
  [switch]$NoHud,
  [switch]$Stop,
  [switch]$InstallStartup,
  [switch]$RemoveStartup
)

$ErrorActionPreference = 'Stop'
$profileDir = Join-Path $env:LOCALAPPDATA 'hockey-wallpaper-profile'
$startupLnk = Join-Path ([Environment]::GetFolderPath('Startup')) 'Arcade Ice Hockey Wallpaper.lnk'

function Stop-Wallpaper {
  Get-CimInstance Win32_Process -Filter "Name='msedge.exe' OR Name='chrome.exe'" |
    Where-Object { $_.CommandLine -like "*hockey-wallpaper-profile*" } |
    ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
}

if ($Stop) { Stop-Wallpaper; Write-Host 'Wallpaper stopped.'; return }
if ($RemoveStartup) { Remove-Item $startupLnk -ErrorAction SilentlyContinue; Write-Host 'Startup entry removed.'; return }
if ($InstallStartup) {
  $ws = New-Object -ComObject WScript.Shell
  $lnk = $ws.CreateShortcut($startupLnk)
  $lnk.TargetPath = (Get-Command powershell.exe).Source
  $lnk.Arguments = "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$PSCommandPath`" -Fps $Fps -Diff $Diff -Goals $Goals" + $(if ($NoHud) { ' -NoHud' } else { '' })
  $lnk.WindowStyle = 7
  $lnk.Save()
  Write-Host "Will start at login: $startupLnk"
  return
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class W32 {
  public static IntPtr Progman() { return FindWindow("Progman", null); }
  public static IntPtr Child(IntPtr p, string cls) { return FindWindowEx(p, IntPtr.Zero, cls, null); }
  public delegate bool EnumProc(IntPtr h, IntPtr l);
  [DllImport("user32.dll")] public static extern IntPtr FindWindow(string c, string t);
  [DllImport("user32.dll")] public static extern IntPtr FindWindowEx(IntPtr p, IntPtr a, string c, string t);
  [DllImport("user32.dll")] public static extern bool EnumWindows(EnumProc p, IntPtr l);
  [DllImport("user32.dll")] public static extern IntPtr SendMessageTimeout(IntPtr h, uint m, UIntPtr w, IntPtr l, uint f, uint t, out UIntPtr r);
  [DllImport("user32.dll")] public static extern IntPtr SetParent(IntPtr c, IntPtr p);
  [DllImport("user32.dll")] public static extern int SetWindowLong(IntPtr h, int i, int v);
  [DllImport("user32.dll")] public static extern bool SetWindowPos(IntPtr h, IntPtr a, int x, int y, int cx, int cy, uint f);
  [DllImport("user32.dll")] public static extern bool SetProcessDPIAware();

  // Returns the window that sits behind the desktop icons (works on Win10 and Win11 incl. 24H2).
  public static IntPtr FindWorkerW() {
    IntPtr progman = FindWindow("Progman", null);
    UIntPtr r;
    SendMessageTimeout(progman, 0x052C, UIntPtr.Zero, IntPtr.Zero, 0, 1000, out r);
    IntPtr child = FindWindowEx(progman, IntPtr.Zero, "WorkerW", null);   // Win11 24H2+
    if (child != IntPtr.Zero) return child;
    IntPtr found = IntPtr.Zero;                                            // Win10 / older Win11
    EnumWindows(delegate (IntPtr h, IntPtr l) {
      if (FindWindowEx(h, IntPtr.Zero, "SHELLDLL_DefView", null) != IntPtr.Zero)
        found = FindWindowEx(IntPtr.Zero, h, "WorkerW", null);
      return true;
    }, IntPtr.Zero);
    return found;
  }
}
"@
[void][W32]::SetProcessDPIAware()

Stop-Wallpaper
Start-Sleep -Seconds 2

$browser = @(
  "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
  "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
  "$env:ProgramFiles\Google\Chrome\Application\chrome.exe"
) | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $browser) { throw 'Microsoft Edge or Google Chrome is required.' }

$page = (Resolve-Path (Join-Path $PSScriptRoot '../index.html')).Path.Replace([string][char]92, '/')
$hud = if ($NoHud) { 0 } else { 1 }
$url = "file:///${page}?diff=${Diff}&goals=${Goals}&fps=${Fps}&hud=${hud}"

$vs = [System.Windows.Forms.SystemInformation]::VirtualScreen
$ps = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds

Start-Process $browser -ArgumentList @(
  "--kiosk", "--app=$url", "--edge-kiosk-type=fullscreen", "--user-data-dir=$profileDir", '--no-first-run', '--no-default-browser-check',
  '--disable-features=Translate', "--window-position=$($ps.X),$($ps.Y)", "--window-size=$($ps.Width),$($ps.Height)",
  '--autoplay-policy=no-user-gesture-required'
)

$hwnd = [IntPtr]::Zero
for ($i = 0; $i -lt 60 -and $hwnd -eq [IntPtr]::Zero; $i++) {
  Start-Sleep -Milliseconds 500
  $p = Get-Process -Name msedge,chrome -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -like '*Arcade Ice Hockey Wallpaper*' } | Select-Object -First 1
  if ($p) { $hwnd = $p.MainWindowHandle }
}
if ($hwnd -eq [IntPtr]::Zero) { throw 'Could not find the wallpaper window.' }

$progman = [W32]::Progman()
$worker  = [W32]::FindWorkerW()
if ($worker -eq [IntPtr]::Zero) { Stop-Wallpaper; throw 'Could not find the desktop layer (WorkerW).' }
$win11new = ([W32]::Child($progman, 'WorkerW') -ne [IntPtr]::Zero)

[void][W32]::SetWindowLong($hwnd, -16, -1879048192)    # WS_POPUP | WS_VISIBLE : borderless
$x = $ps.X - $vs.X; $y = $ps.Y - $vs.Y
if ($win11new) {
  # Windows 11 24H2+: become a child of Progman, stacked just under the icon layer and above the wallpaper layer.
  $defView = [W32]::Child($progman, 'SHELLDLL_DefView')
  [void][W32]::SetParent($hwnd, $progman)
  [void][W32]::SetWindowPos($hwnd, $defView, $x, $y, $ps.Width, $ps.Height, 0x60)
} else {
  [void][W32]::SetParent($hwnd, $worker)
  [void][W32]::SetWindowPos($hwnd, [IntPtr]::Zero, $x, $y, $ps.Width, $ps.Height, 0x64)
}
Write-Host "Wallpaper running on primary display ($($ps.Width)x$($ps.Height)). Stop with: -Stop"
