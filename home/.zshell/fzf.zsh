#!/bin/zsh

# Sets up default integrations + keybindings
source <(fzf --zsh)

# Enable multi-mode
export FZF_DEFAULT_OPTS="-m"

# Loads history into zsh prompt
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# Directory history jumping
fcd() {
  eval "cd $(dirs -v | cut -f2 | fzf)"
}


# Thanks to @benvan
__list_git_branches_timewise(){
  git reflog -n10000 --pretty='%cr|%gs' --grep-reflog='checkout: moving' HEAD | {
    seen=":"
    git_dir="$(git rev-parse --git-dir)"
    while read line; do
      date="${line%%|*}"
      branch="${line##* }"
      if ! [[ $seen == *:"${branch}":* ]]; then
        seen="${seen}${branch}:"
        if [ -f "${git_dir}/refs/heads/${branch}" ]; then
          printf "%s\t%s\n" "$date" "$branch"
        fi
      fi
    done
  } | head -n 20
}


goo() {
 git checkout "$(__list_git_branches_timewise | fzf | cut -f2)"
}

goa() {
 git checkout "$(git branch --all | fzf | tr -d '[:space:]')"
}
