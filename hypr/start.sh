#! /bin/bash

swww kill
killall swww
pkill swww
swww-daemon &
swww img ~/.config/hypr/wallpaper.png -t none

./.config/eww/scripts/start.sh

seadrive-gui & 

