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

echo -ne "\x1B[33m~/Install prezto?[yn]\x1B[39m"
read -n 1
echo ""
if [[ $REPLY =~ [yY] ]]; then
    mkdir -p ~/.cache/zsh
    touch ~/.cache/zsh/dirs
    zsh -c "git clone --recursive https://github.com/sorin-ionescu/prezto.git \
            \"${ZDOTDIR:-$HOME}/.zprezto\""
    echo -e "\nChanging default shell to zsh"
    chsh -s /bin/zsh
else
    echo -ne "\x1B[33m~/Update prezto?[yn]\x1B[39m"
    read -n 1
    echo ""
    if [[ $REPLY =~ [yY] ]]; then
        zsh -c "cd ~/.zprezto && git pull && git submodule update --init --recursive"
    fi
fi

echo -ne "\x1B[33m~/Install NeoBundle?[yn]\x1B[39m"
read -n 1
echo ""
if [[ $REPLY =~ [yY] ]]; then
    curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
fi


echo -ne "\x1B[33m~/Install fzf?[yn]\x1B[39m"
read -n 1
echo ""
if [[ $REPLY =~ [yY] ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi
