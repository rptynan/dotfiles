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
alias c="clear"

# Fun
alias vimsnake="bash ~/.zshell/vimsnake.sh"

# Dirs
alias darw="cd ~/code/darwin"
alias dash="cd ~/code/dashboard"

# Darwin
alias tw="yarn workspace @metomic/darwin test:watch"
alias ppf="./infra/production/open-prod-portforwards.sh"
alias spf="./infra/staging/open-staging-portforwards.sh"
