###Source Prezto###
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


###DirStack Setup###
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >! $DIRSTACKFILE
}
DIRSTACKSIZE=20
setopt autopushd pushdsilent pushdtohome
## Remove duplicate entries
setopt pushdignoredups


###Enable 256 Colours###
export TERM="xterm-256color"


###Aliases###
#Overwrites#
alias rm="rm -I"
alias ls='ls --color=auto'
alias xflux="xflux -l 53.4129 -g -8.2439"
alias xclip="xclip -selection clipboard"
#Conviences#
alias dutreesize="du --max-depth=1 -h"
alias grepsauce="ps aux | grep "
alias setus="setxkbmap -layout 'us' && setxkbmap -option caps:escape"
alias setie="setxkbmap -layout 'ie'"


###Shell Setup###
#General#
bindkey -v
export EDITOR="vim"
export VISUAL="vim"
fortune



###Commands###

function pacman-remove-orphans()
{
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo "No orphans to remove."
    else
        sudo pacman -Rns $(pacman -Qdtq)
     fi
}

function swap()
{
    local TMPFILE=tmp.$$
	mv "$1" $TMPFILE
	mv "$2" "$1"
	mv $TMPFILE "$2"
}

function ListAllCommands
{
    COMMANDS=`echo -n $PATH | xargs -d : -I {} find {} -maxdepth 1 \
        -executable -type f -printf '%P\n'`
    ALIASES=`alias | cut -d '=' -f 1`
    echo "$COMMANDS"$'\n'"$ALIASES" | sort -u
}
