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

# Merge Clipboards
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

# Swap Caps Lock and Escape
setxkbmap -option caps:escape

# Set Chromium to open with touch screen enabled (xinput list to find id)
# export CHROMIUM_FLAGS="--touch-devices=9"

# Set power management on wifi card off (makes it more stable for some reason)
# sudo iw wlp2s0 set power_save off

# Set environmental variable to show i3 is running
export DESKTOP_SESSION="i3"

# Run i3
exec i3
