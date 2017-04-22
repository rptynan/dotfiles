#!/bin/zsh

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source other stuff
for file in ~/.zshell/*.zsh; do
    source $file
done

# Source envs
source /usr/local/src/part2-dissertation-code/scripts/envs.sh
