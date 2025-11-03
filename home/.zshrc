#!/bin/zsh

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export VISUAL="nvim"
export EDITOR="nvim"

# Monzo-specific
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
[ -f ${GOPATH}/src/github.com/monzo/starter-pack/zshrc ] && source ${GOPATH}/src/github.com/monzo/starter-pack/zshrc
export PYENV_ROOT=$(brew --prefix)/var/pyenv
export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi
export PATH=/Users/richardtynan/.local/bin:$PATH
source /opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/path.zsh.inc
source /opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/completion.zsh.inc
export CLOUDSDK_PYTHON=
export OAUTHLIB_RELAX_TOKEN_SCOPE=1
source /Users/richardtynan/src/github.com/monzo/analytics/dbt/misc/shell/source.sh
export PATH=/Users/richardtynan/.local/bin:$PATH

# Source other stuff
# Some of this has to be after the above, e.g. dirstack
for file in ~/.zshell/*.zsh; do
    source $file
done

