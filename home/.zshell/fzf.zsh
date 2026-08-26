#!/bin/zsh

# Sets up default integrations + keybindings
source <(fzf --zsh)

# Enable multi-mode
export FZF_DEFAULT_OPTS="-m"

# Display options
export FZF_COMPLETION_OPTS='--style=full'
export FZF_CTRL_R_OPTS='--style=full'

# Directory history jumping
# Relies on dirstack.zsh being run first
fd() {
  eval "cd $(cat "$DIRSTACKFILE" | cut -f2 | fzf)"
}


# Thanks to @benvan
__list_git_branches_timewise(){
  git reflog -n10000 --pretty='%cr|%gs' --grep-reflog='checkout: moving' HEAD | {
    seen=":"
    while read line; do
      date="${line%%|*}"
      branch="${line##* }"
      if ! [[ $seen == *:"${branch}":* ]]; then
        seen="${seen}${branch}:"
        if git show-ref --verify --quiet "refs/heads/${branch}"; then
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
