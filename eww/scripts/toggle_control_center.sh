#!/bin/bash

state=$(eww get open_control_center)

echo "$state"

open_control_center() {
    if [[ -z $(eww list-windows | grep '*control_center') ]]; then
        eww open control_center
        eww open control_center-closer
    fi
    eww update open_control_center=true
}

close_control_center() {
    eww close control_center
    eww close control_center-closer
    eww update open_control_center=false
}

case $1 in
    close)
        close_control_center
        exit 0;;
esac

case $state in
    true)
        close_control_center
        exit 0;;
    false)
        open_control_center
        exit 0;;
esac