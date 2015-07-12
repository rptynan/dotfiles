#!/bin/zsh

function spoofmac() {
    if [ -z "$*" ]; then
        echo "Usage: spoofmac <profile-name> <mac-address>"
        echo "List of profiles:"
        nmcli con show
        echo "Add new profile by running:"
        echo "nmcli dev wifi con <SSID> name <profile-name>"
    else
        nmcli con down id $1
        nmcli con modify $1 802-11-wireless.cloned-mac-address $2
        nmcli con up id $1
    fi
    echo "Current MAC address:"
    ip link show wlp2s0 | grep "link/ether" | cut -d " " -f 6
}

function clipit() {
    LC=$(history -1 | cut -d ' ' -f 4-)
    echo -n $LC | xclip
}

function spellcheck() {
    echo $1 | aspell -a
}

function load-vbox-modules() {
    for i in "vboxdrv" "vboxnetflt" "vboxpci" "vboxnetadp"; do
        sudo modprobe $i
    done
}

function pacman-remove-orphans() {
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo "No orphans to remove."
    else
        sudo pacman -Rns $(pacman -Qdtq)
    fi
}

function swap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function ListAllCommands {
    COMMANDS=`echo -n $PATH | xargs -d : -I {} find {} -maxdepth 1 \
        -executable -type f -printf '%P\n'`
    ALIASES=`alias | cut -d '=' -f 1`
    echo "$COMMANDS"$'\n'"$ALIASES" | sort -u
}
