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
xrandr --dpi 165

# Disable bell
xset -b

# Load Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Set Wallpaper
feh --bg-fill --randomize ~/.wallpapers/*

# Merge Clipboards
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

# Swap Caps Lock and Escape
setxkbmap -option caps:escape

exec i3
