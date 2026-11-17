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
alias k="kubectl"
alias ask="claude -p --model=sonnet"
alias trn='tmux rename-window -t "$TMUX_PANE"'
alias tmv='tmux swap-window -t'

# Fun
alias vimsnake="bash ~/.zshell/vimsnake.sh"

# Dirs
alias wad="cd ~/src/github.com/monzo/wearedev/"
alias anl="cd ~/src/github.com/monzo/analytics/"
