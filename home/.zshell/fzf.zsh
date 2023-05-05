#!/bin/zsh

# Enable multi-mode
export FZF_DEFAULT_OPTS="-m"

# Loads history into zsh prompt
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

go() {
 git checkout "$(git branch | fzf | tr -d '[:space:]')"
}

goa() {
 git checkout "$(git branch --all | fzf | tr -d '[:space:]')"
}
