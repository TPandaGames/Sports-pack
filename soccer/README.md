# Soccer Wallpaper

Top-down 3-a-side soccer (a goalkeeper and two outfield players each): **BLUE vs RED**, CPU against CPU, 2-minute matches that
restart forever. No assets, fully offline.

- **The CPU game:** the player nearest the ball chases it, dribbles toward goal, passes to a teammate when an opponent blocks the
  way, and shoots from range at the corner the keeper isn't covering. The other outfielder runs support, and the keepers read
  shots and clear loose balls. After a goal there's a kickoff; at full time a banner shows the result and a new match starts.
- **Interactive:** open `index.html` in a browser and move the mouse to take over BLUE's active outfield player (ringed in white) —
  you run to the cursor, and **click to kick toward it** (farther from the ball = harder). Stop for a few seconds and the CPU takes
  back over.
- **As a desktop wallpaper:** a wallpaper pinned behind your icons can't receive clicks, so there it just plays itself.

Page options: `index.html?hud=0&auto=0&delay=8&time=90&fps=30`
(`hud` 0/1, `auto=0` makes BLUE always mouse-controlled, `delay` idle seconds before the CPU takes over, `time` match length in
seconds, `fps` 15-120).

## Windows desktop wallpaper (nothing to install)
Double-click [`windows/start.bat`](windows/start.bat); stop with [`windows/stop.bat`](windows/stop.bat).
Same PowerShell + Edge method as the other sports (see [`../hockey/wallpaper/README.md`](../hockey/wallpaper/README.md));
options: `soccer-wallpaper.ps1 -Fps 30 -NoHud`, `-InstallStartup`, `-RemoveStartup`. Primary monitor only.
Starting one wallpaper doesn't stop another, so run the matching `stop.bat` first when switching.

## Linux
Same options as the hockey wallpaper (e.g. `xwinwrap` + a browser on X11). Untested.
