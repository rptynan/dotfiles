#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

echo -ne "\x1B[33m~/Install pacman-available packages listed in notes/packagelist?[yn]\x1B[39m"
read -n 1
echo ""
if [[ $REPLY =~ [yY] ]]; then
    sudo pacman -S --needed $(comm -12 <(pacman -Slq|sort) <(sort $DIR/notes/packagelist) )
fi

echo -ne "\x1B[33m~/Link all files in bin to /usr/local/bin?[yn]\x1B[39m"
read -n 1
echo ""
if [[ $REPLY =~ [yY] ]]; then
    for file in $(ls $DIR/bin); do
        sudo ln -s `pwd`/bin/$file /usr/local/bin/$file
    done
fi

echo -ne "\x1B[33m~/Install NeoBundle and Vim solarized colorscheme?[yn]\x1B[39m"
read -n 1
echo ""
if [[ $REPLY =~ [yY] ]]; then
    # NeoBundle
    curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
    # Vim solarized
    cp $DIR/notes/solarized.vim ~/.vim/colors
fi
