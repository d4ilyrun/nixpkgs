#!/usr/bin/env bash

menu="$1"
dir=$2

if [ "$menu" = "powermenu" ]; then
    rofi -modi "Powermenu:$dir/powermenu.sh" -show Powermenu -theme powermenu -location 3 -xoffset -30 -yoffset 86
fi
