# Water Polo Wallpaper

Top-down water polo: **BLUE vs RED**, four a side (a goalkeeper and three swimmers), CPU against CPU, 2-minute matches that
restart forever. No assets, fully offline.

- **The game:** swimmers race for the floating ball (a swim-off at the start and after every goal), grab it and carry it, then
  throw passes and shots. Hard shots can only be blocked or deflected; slower passes get caught. Swimmers next to the ball
  carrier can wrestle it away, and a swimmer who holds the ball for 6 seconds has to shoot. When the other team has the ball your
  swimmers mark attackers goal-side; when you have it they spread out as wings and a centre-forward. The keepers read shots
  and grab loose balls in the goal area.
- **Interactive:** open `index.html` in a browser and move the mouse to take over BLUE's active swimmer (ringed in white): you
  swim to the cursor. **Click to throw toward the cursor** when you have the ball (farther = harder), or **click to sprint**
  when you don't. Stop for a few seconds and the CPU takes back over.
- **As a desktop wallpaper:** a wallpaper pinned behind your icons can't receive clicks, so there it just plays itself.

Page options: `index.html?hud=0&auto=0&delay=8&time=90&fps=30`
(`hud` 0/1, `auto=0` makes BLUE always mouse-controlled, `delay` idle seconds before the CPU takes over, `time` match length in
seconds, `fps` 15-120).

## Windows desktop wallpaper (nothing to install)
Double-click [`windows/start.bat`](windows/start.bat); stop with [`windows/stop.bat`](windows/stop.bat).
Same PowerShell + Edge method as the other sports (see [`../hockey/wallpaper/README.md`](../hockey/wallpaper/README.md));
options: `polo-wallpaper.ps1 -Fps 30 -NoHud`, `-InstallStartup`, `-RemoveStartup`. Primary monitor only.
Starting one wallpaper doesn't stop another, so run the matching `stop.bat` first when switching. If another live-wallpaper app
(e.g. a desktop wallpaper engine) is running it may draw over this one - close it first.

## Linux
Same options as the hockey wallpaper (e.g. `xwinwrap` + a browser on X11). Untested.
