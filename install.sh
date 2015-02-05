#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd )"

echo -ne "\x1B[33m~/Install pacman-available packages listed in notes/packagelist?[yn]\x1B[39m"
read -n 1
echo ""
if [[ $REPLY =~ [yY] ]]; then
    sudo pacman -S --needed $(comm -12 <(pacman -Slq|sort) <(sort notes/packagelist) )
fi

echo -ne "\x1B[33m~/Link all files in bin to /usr/local/bin?[yn]\x1B[39m"
read -n 1
echo ""
if [[ $REPLY =~ [yY] ]]; then
    for file in $(ls bin); do
        sudo ln -s `pwd`/bin/$file /usr/local/bin/$file
    done
fi

echo -ne "\x1B[33m~/Install pathogen and syntastic?[yn]\x1B[39m"
read -n 1
echo ""
if [[ $REPLY =~ [yY] ]]; then
    # Pathogen
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
        curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    # Syntastic
    cd ~/.vim/bundle && \
        git clone https://github.com/scrooloose/syntastic.git
fi
