# Arcade Ice Hockey – Live Wallpaper

CPU vs CPU hockey that plays itself forever. Fully offline, no assets. `index.html` is the whole wallpaper.

URL options: `index.html?hud=0&diff=allstar&goals=7&fps=30`
(`hud` 0/1, `diff` rookie|pro|allstar, `goals` N, `fps` 15-120). Lower `fps` to save battery/GPU.

## Windows
**Lively Wallpaper (free):** Add Wallpaper -> drag this folder (or `index.html`) in. `LivelyInfo.json` and
`LivelyProperties.json` give you in-app settings. Lively pauses the wallpaper when a fullscreen app is focused.

**Wallpaper Engine (Steam):** Wallpaper Editor -> Create Wallpaper -> select `index.html`
(or Open from file using `project.json`), then publish/apply.

## Linux (not tested here)
- **GNOME / most desktops:** Hidamari (Flatpak) supports web-page wallpapers. Point it at `file:///path/to/wallpaper/index.html`
  (add `?hud=0` etc. as desired).
- **X11 fallback:** run the page in a borderless window pinned to the desktop layer, e.g.
  `xwinwrap -g 1920x1080+0+0 -ni -s -nf -b -un -ov -- chromium --app="file:///path/to/wallpaper/index.html" --window-position=0,0`
- **KDE Plasma:** a web/HTML wallpaper plugin from the KDE Store can load the same file.
- **Wayland:** wlroots compositors (Sway, Hyprland) can use a web-wallpaper tool such as `mpvpaper`-style
  browser wrappers; support varies by compositor.
