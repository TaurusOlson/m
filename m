#!/bin/bash


# Description: A very simple script aiming to ease the use of mpc
# m uses a set of simplified commands that are used frequently in mpc.
# All the commands in mpc can be used with m.

DEFAULT="\e[0m"
RED="\e[0;31m"
YELLOW="\e[0;33m"

function usage() {
    printf "${RED}NAME
    $(basename $0) - A wrapper for mpc

${RED}SYNOPSIS
    $(basename $0) [commands]

${RED}DESCRIPTION
    $(basename $0) uses a set of simplified commands that are used frequently in mpc.
    All the commands in mpc can be used with m.

commands:
    h   : print this help message
    n   : play next track
    p   : play previous track
    s   : display the status
    u   : empty the playlist and update the database
    -   : decrease volume
    +   : increase volume
    l   : print entire playlist
    <n> : jump to the nth track" | less -R
}

# Start mpd if it's not already the case
[ -z "$(ps x | grep mpd | grep -v "grep mpd")" ] && mpd && echo "♫ Launched mpd ♫"

# Toggle mpc
[ $# -eq 0 ] && mpc toggle && exit 0

if [ $# -eq 1 ]; then
    case "$1" in
        "n"|"next") mpc next
            ;;
        "p"|"prev"|"previous") mpc prev
            ;;
        "s"|"status") mpc status
            ;;
        "-") mpc volume -10
            ;;
        "+") mpc volume +10
            ;;
        "l") mpc playlist | cat -b
            ;;
        "u") mpc clear && mpc update
            ;;
        "h"|"--help") usage
            ;;
        # Use regexes if possible
        0*|1*|2*|3*|4*|5*|6*|7*|8*|9*) mpc play $1
            ;;
        *) mpc "$@"
            ;;
    esac
else
    mpc "$@"
fi

