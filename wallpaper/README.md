# Arcade Ice Hockey – Live Wallpaper

CPU vs CPU hockey that plays itself forever. Fully offline, no assets, **no extra app to install**.
`index.html` is the whole wallpaper.

Page options (URL query): `index.html?hud=0&diff=allstar&goals=7&fps=30`
(`hud` 0/1, `diff` rookie|pro|allstar, `goals` N, `fps` 15-120). Lower `fps` to save battery/GPU.

## Windows (nothing to install)
Uses only PowerShell and Microsoft Edge, both built into Windows 10/11. The script opens the page in a
borderless Edge window and pins it behind your desktop icons.

1. Double-click [`windows/start.bat`](windows/start.bat) (runs on your primary display).
2. Stop it any time with [`windows/stop.bat`](windows/stop.bat).

From a terminal, for options:
```
powershell -ExecutionPolicy Bypass -File windows\hockey-wallpaper.ps1 -Fps 30 -Diff allstar -Goals 7 -NoHud
powershell -ExecutionPolicy Bypass -File windows\hockey-wallpaper.ps1 -InstallStartup   # run at login
powershell -ExecutionPolicy Bypass -File windows\hockey-wallpaper.ps1 -RemoveStartup
```
Tested on Windows 11 24H2 (also handles the older Win10/Win11 desktop layout). Primary monitor only.
Wallpaper Engine users can alternatively load `project.json`.

## Linux (not tested here)
No-install options use a browser you already have:
- **X11:** pin a borderless browser window to the desktop layer, e.g.
  `xwinwrap -g 1920x1080+0+0 -ni -s -nf -b -un -ov -- chromium --app="file:///path/to/wallpaper/index.html"`
  (`xwinwrap` is a small package in most distros' repos).
- **KDE Plasma:** a web/HTML wallpaper plugin from the KDE Store can load the same file.
- **GNOME / Wayland:** there is no built-in way to run a web page as a wallpaper; a helper tool is required
  (for example Hidamari). Support varies by compositor.
