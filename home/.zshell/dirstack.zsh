#!/bin/zsh

# DirStack Setup
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  # Only restore directory if not inside tmux (tmux panes should
  # inherit the directory they were opened with via -c or split from)
  if [[ -z $TMUX ]]; then
    [[ -d $dirstack[1] ]] && cd $dirstack[1]
  fi
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >! $DIRSTACKFILE
}
DIRSTACKSIZE=100
setopt autopushd pushdsilent
# Remove duplicate entries
setopt pushdignoredups
