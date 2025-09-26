#!/bin/zsh

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source other stuff
for file in ~/.zshell/*.zsh; do
    source $file
done

export VISUAL="nvim"
export EDITOR="nvim"

# Monzo-specific
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
[ -f ${GOPATH}/src/github.com/monzo/starter-pack/zshrc ] && source ${GOPATH}/src/github.com/monzo/starter-pack/zshrc
