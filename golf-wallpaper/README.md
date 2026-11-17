# Golf Wallpaper

Top-down mini golf: 3 holes (a bumper, a dogleg, and a water hazard + sand trap) that loop forever. No assets, fully offline.

- **Interactive:** open `index.html` in a browser. Drag back from anywhere and release to putt, like a slingshot.
  The arrow shows direction and power (yellow -> red).
- **Self-playing:** leave it alone for ~5 seconds and a CPU golfer takes over (it routes around obstacles and water,
  and misses sometimes). Move or click the mouse to take the club back.
- **As a desktop wallpaper:** a wallpaper pinned behind your icons can't receive clicks, so there it runs in self-playing mode.

Page options: `index.html?hud=0&auto=0&delay=8&fps=30`
(`hud` 0/1, `auto=0` turns the CPU golfer off, `delay` idle seconds before the CPU plays, `fps` 15-120).

## Windows desktop wallpaper (nothing to install)
Double-click [`windows/start.bat`](windows/start.bat); stop with [`windows/stop.bat`](windows/stop.bat).
Same PowerShell + Edge method as the hockey wallpaper (see [`../wallpaper/README.md`](../wallpaper/README.md)); options:
`golf-wallpaper.ps1 -Fps 30 -NoHud`, `-InstallStartup`, `-RemoveStartup`. Primary monitor only.
Starting one wallpaper doesn't stop the other, so run the matching `stop.bat` first when switching.

## Linux
Same options as the hockey wallpaper (e.g. `xwinwrap` + a browser on X11). Untested.
