#!/bin/bash

pamixer --default-source --get-mute

pactl subscribe | rg --line-buffered "on source" | while read -r _; do
  pamixer --default-source --get-mute
done