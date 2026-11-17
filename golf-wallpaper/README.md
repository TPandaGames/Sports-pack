# Golf Wallpaper

Top-down mini golf with **two CPU golfers, BLUE and RED, competing head to head** over 9 holes that loop forever
(bumper, dogleg, water + sand, S-curve, a narrow gate, bunker, lake, U-turn and a final gauntlet). No assets, fully offline.

- **Match play:** they take turns like real golf (whoever is farthest from the cup putts next, and the winner of the last
  hole gets the honors). Fewest strokes wins the hole; the scoreboard (top right) shows strokes this hole, holes won and total
  strokes. After hole 9 a banner announces the match winner, then a new match starts. BLUE is a slightly steadier putter than
  RED, but either can win. A golfer who is hopelessly stuck picks up at par + 6.
- **Interactive:** open `index.html` in a browser. When it's a golfer's turn you can take the shot yourself - drag back from
  anywhere and release, like a slingshot. The arrow shows direction and power (yellow -> red). Stop touching the mouse for a few
  seconds and the CPU takes the club back.
- **As a desktop wallpaper:** a wallpaper pinned behind your icons can't receive clicks, so there it just plays itself.

Page options: `index.html?hud=0&auto=0&delay=8&fps=30`
(`hud` 0/1, `auto=0` turns the CPU golfers off so only you putt, `delay` idle seconds before the CPU plays, `fps` 15-120).

## Windows desktop wallpaper (nothing to install)
Double-click [`windows/start.bat`](windows/start.bat); stop with [`windows/stop.bat`](windows/stop.bat).
Same PowerShell + Edge method as the hockey wallpaper (see [`../wallpaper/README.md`](../wallpaper/README.md)); options:
`golf-wallpaper.ps1 -Fps 30 -NoHud`, `-InstallStartup`, `-RemoveStartup`. Primary monitor only.
Starting one wallpaper doesn't stop the other, so run the matching `stop.bat` first when switching.

## Linux
Same options as the hockey wallpaper (e.g. `xwinwrap` + a browser on X11). Untested.
