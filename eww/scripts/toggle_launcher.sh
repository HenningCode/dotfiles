#!/bin/bash


state=$(eww get open_launcher)

open_launcher() {
    if [[ -z $(eww windows | grep '*launcher') ]]; then
        eww open launcher
        eww open launcher-closer
    fi
    eww update open_launcher=true
    sleep 0.5 && ~/.config/eww/scripts/apps.py &
}

close_launcher() {
    eww close launcher
    eww close launcher-closer
    eww update open_launcher=false
    ~/.config/eww/scripts/apps.py &
}

case $1 in
    close)
        close_launcher
        exit 0;;
    open)
        open_launcher
        exit 0;;
esac

case $state in
    true)
        close_launcher
        exit 0;;
    false)
        open_launcher
        exit 0;;
esac
