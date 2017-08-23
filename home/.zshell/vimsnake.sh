#!/usr/bin/env bash
# Snake clone in Bash, by rptynan
# Inspired by http://bruxy.regnet.cz/web/linux/EN/housenka-bash-game/


## Globals ##

TIMESTEP=0.1
DIR="C"         # Start going right
LASTDIR="C"     # So we don't allow going back on ourselves (see below)
SCORE=0
ATE=false
FOOD=""

# Excluding borders
HEIGHT=20
WIDTH=25

# 0 is head pos, coordinates are y;x beginning in top left
HEADY=$(($HEIGHT / 2 + 1))
HEADX=$(($WIDTH / 2 + 1))
SNAKE=(
    [0]="$HEADY;$HEADX"
    [1]="$HEADY;$(($HEADX - 1))"
    [2]="$HEADY;$(($HEADX - 2))"
)


## Utility functions ##

# $1 char to repeat
# $2 number of times to repeat
# -n adds newline at end
function rep() {
    # This parsing is such overkill but it's just for learning/fun
    NEWLINE=false
    args=()
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -n) NEWLINE=true
                shift
            ;;
            *) args+=("$1")
               shift
            ;;
        esac
    done

    for ((i=0; i < ${args[1]}; i++)); do
        printf "${args[0]}"
    done
    $NEWLINE && printf "\n"
}

# Prints $1 at coordinates $2 (Y;X format) with colours $3 and optionally $4
function printxy() {
    # 30-37 is fg colour, 40-47 is bg colour
    col1="\e[1;$3m"
    col2=""
    [ ! -z "$4" ] && col2="\e[1;$4m"
    nocolour="\e[0m"
    # Prints at position and them moves cursor back to bottom of board
    position="\e[$2f"
    resetposition="\e[$(($HEIGHT + 3));1f"
    printf "$position$col1$col2$1$nocolour$resetposition"
}

# Gives the opposite direction's letter
function opposite_dir() {
    # Directions:
    #     A
    #    D C
    #     B
    case "$1" in
        A) echo "B" ;;
        B) echo "A" ;;
        C) echo "D" ;;
        D) echo "C" ;;
    esac
}


## Game control and logic ##

# Prints the board
function gen_board() {
    clear
    col="\e[1;44m\e[1;34m"
    nocol="\e[1;0m"
    rep "$col#$nocol" $((WIDTH + 2)) -n
    rep "$col#$nocol$(rep " " $WIDTH)$col#$nocol\n" $HEIGHT
    rep "$col#$nocol" $((WIDTH + 2)) -n
}

# Moves the snake one forward and prints it
function gen_snake() {
    case "$DIR" in
        A) HEADY=$(($HEADY - 1))
           LASTDIR="A"
           # echo "UP"
        ;;
        B) HEADY=$(($HEADY + 1))
           LASTDIR="B"
           # echo "DOWN"
        ;;
        C) HEADX=$(($HEADX + 1))
           LASTDIR="C"
           # echo "RIGHT"
        ;;
        D) HEADX=$(($HEADX - 1))
           LASTDIR="D"
           # echo "LEFT"
        ;;
    esac
    if $ATE; then
        ATE=false                           # We ate, so we get longer
    else
        unset 'SNAKE[-1]'                   # Pop last element of snake body
    fi
    SNAKE=("$HEADY;$HEADX" ${SNAKE[@]})     # Push new element in first
    for piece in ${SNAKE[@]}; do
        printxy "X" $piece 42 32            # Green fg and bg
    done
}

function gen_food() {
    if [[ -z $FOOD ]]; then
        FOOD="$(($RANDOM % $HEIGHT + 2));$(($RANDOM % $WIDTH + 2))"
    fi
    printxy "F" $FOOD 41 31     # Red fg and bg
}

function die() {
    kill -EXIT $$
    echo "DEATH"
    exit
}

# Fairly obvious
function did_we_die() {
    # Did we hit a wall?
    if (( $HEADY <= 1 )) || (( $HEADY > $(($HEIGHT + 1)))); then die; fi
    if (( $HEADX <= 1 )) || (( $HEADX > $(($WIDTH + 1)))); then die; fi
    # Did we hit ourselves?
    if [[ $(echo ${SNAKE[@]} | tr " " "\n" | sort | uniq -D) ]]; then
        die
    fi
}

# If we ate, increase score, set ATE and unset FOOD
function did_we_eat() {
    if [[ "${SNAKE[0]}" == "$FOOD" ]]; then
        ATE=true
        SCORE=$((SCORE + 1))
        FOOD=""
    fi
    printf $SCORE
}

function step() {
    gen_board
    gen_snake
    gen_food
    did_we_die
    did_we_eat
    (sleep $TIMESTEP; kill -ALRM $$) &    # Run step again
}

function at_exit() {
    trap : ALRM
    echo "Score: $SCORE"
    printf "\e[?25h"                # Cursor on
}


## Main ##

# Set up
exec 2>/dev/null                    # Prevents errors stopping us
printf "\e[?25l"                    # Cursor off
trap at_exit EXIT                   # Run on exit to reset things
trap step ALRM                      # Runs regularly to progress game
step
while true; do
    read -rsn1 -d ' ' PRESS
    if echo $PRESS | grep -qE "h|j|k|l"; then
        # Vim keys case, substitute for arrow escape letters
        PRESS=$(echo $PRESS | sed "s/h/D/g; s/j/B/g; s/k/A/g; s/l/C/g")
    else
        # Arrows case, read in next two chars and take out last
        read -rsn2 -d ' ' PRESS && PRESS=${PRESS:1}
    fi
    # Two things have to be true to have a new direction:
    # - PRESS is not empty
    # - The new direction isn't the opposite of the direction we are currently
    #   travelling in. We have to use a separate variable (LASTDIR) which is
    #   only set on actual movement so that we don't read a sequence of, for
    #   example, up-left-down, but do it so quickly that the snake only
    #   refreshes for the up and down, causing it to double back on itself and
    #   die.
    [ ! -z $PRESS ] && \
        [[ "$LASTDIR" != "$(opposite_dir $PRESS)" ]] && \
        DIR=$PRESS
done
