#!/bin/zsh

# Is what it says
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

# Puts last command in clipboard
function clipit() {
    LC=$(history -1 | cut -d ' ' -f 3-)
    echo -n $LC | xclip
}

# Is what it says
function spellcheck() {
    echo $1 | aspell -a
}

# Is what it says
function load-vbox-modules() {
    for i in "vboxdrv" "vboxnetflt" "vboxpci" "vboxnetadp"; do
        sudo modprobe $i
    done
}

# Removes orphaned pacman packages, i.e. ones installed as a dependency which
# now doesn't exist.
function pacman-remove-orphans() {
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo "No orphans to remove."
    else
        sudo pacman -Rns $(pacman -Qdtq)
    fi
}

# Swap two files
function swap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

# Is what it says
function ListAllCommands {
    COMMANDS=`echo -n $PATH | xargs -d : -I {} find {} -maxdepth 1 \
        -executable -type f -printf '%P\n'`
    ALIASES=`alias | cut -d '=' -f 1`
    echo "$COMMANDS"$'\n'"$ALIASES" | sort -u
}

# "Sticky" ssh, reconnects if stops, see
# http://backreference.org/2013/04/26/ssh-auto-reconnect/
function sssh() {
    while true; do
        ssh "$@"
        [[ $? == 0 ]] && break || sleep 1
    done
}
