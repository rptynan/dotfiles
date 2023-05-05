#!/bin/zsh

# Vim mode
bindkey -v
# Edit commands in full vim by doing Esc then v
bindkey -M vicmd v edit-command-line

# Set vim as editor
export EDITOR="vim"
export VISUAL="vim"

# Enable 256 Colours
export TERM="xterm-256color"

# History
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE

# Run at start
if (( $+commands[fortune] )); then
  fortune -a
  print
fi

# Shortcut to suspend half-typed command so I can run another
fancy-ctrl-z () {
  emulate -LR zsh
  if [[ $#BUFFER -eq 0 ]]; then
    bg
    zle redisplay
  else
    zle push-input
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z'          fancy-ctrl-z

# undo this from zprezto
unalias sl
