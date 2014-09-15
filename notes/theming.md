# Current Theme

### Packages Needed
- archlinux-themes-slim
- gtk-theme-numix-solarized
- gtk2-theme-solarizeddark-git
- numix-icon-theme-git
- ttf-dejavu
- ttf-inconsolata
- xcursor-vanilla-dmz


### In lxappearance

- Set Numix Solarized theme, custom colours won't work, see below.
- Set Numix icon theme.
- Set DMZ (White) as cursor.
- And then set all programs to use GTK theme, eg vlc, chromium

### Custom colors in Numix Solarized workaround
Because the custom colors of lxappearance don't work, they have to be changed manual in the theme's files, as follows, to swap solarized green (`#859900`) and solarized blue (`#268bd2`)

For GTK2:

```
# cd /usr/share/themes/Numix\ Solarized/gtk-2.0/
# sed -i 's/#859900/TURNBLUE/' gtkrc
# sed -i 's/#268bd2/TURNGREEN/' gtkrc
# sed -i 's/TURNBLUE/#268bd2/' gtkrc
# sed -i 's/TURNGREEN/#859900/' gtkrc
```

For GTK3:
```
# cd /usr/share/themes/Numix\ Solarized/gtk-3.0/
# for file in *.css; do
    sed -i 's/#859900/TURNBLUE/' $file
    sed -i 's/#268bd2/TURNGREEN/' $file
    sed -i 's/TURNBLUE/#268bd2/' $file
    sed -i 's/TURNGREEN/#859900/' $file
  done
```
