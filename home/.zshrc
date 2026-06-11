#!/bin/zsh

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export VISUAL="nvim"
export EDITOR="nvim"

# Source other stuff
# Some of this has to be after the above, e.g. dirstack
for file in ~/.zshell/*.zsh; do
    source $file
done
