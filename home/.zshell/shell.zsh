#!/bin/zsh

# Vim mode
bindkey -v

# Set vim as editor
export EDITOR="vim"
export VISUAL="vim"

# Enable 256 Colours
export TERM="xterm-256color"

# Run at start
if (( $+commands[fortune] )); then
  fortune -a
  print
fi
