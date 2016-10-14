#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Set DPI
xrandr --dpi 166

# Disable bell
xset -b

# Load Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Set Wallpaper
feh --bg-fill --randomize ~/.wallpapers/*

# Map Caps Lock to Escape
setxkbmap -option caps:escape

# Start coil whine "fix" if present
if [[ -z "$(pgrep whine-be-gone)" ]] && hash whine-be-gone; then
    whine-be-gone &
fi

# Set environmental variable to show i3 is running
export DESKTOP_SESSION="i3"

# Run i3
exec i3
