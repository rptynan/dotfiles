#!/bin/zsh

# Overwrites
alias rm="rm -i"
alias ls='ls -G'
alias xclip="xclip -selection clipboard"
alias sml="rlwrap sml"
alias poly="rlwrap poly"

# Conviences
alias his="history"
alias dutreesize="du --max-depth=1 -h"
alias grepsauce="ps aux | grep "
alias setus="setxkbmap -layout 'us' && setxkbmap -option caps:escape"
alias setie="setxkbmap -layout 'ie'"
alias setde="setxkbmap -layout 'de'"
alias sshs="eval $(ssh-agent) ssh-add"
