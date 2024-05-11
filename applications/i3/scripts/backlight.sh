#!/bin/bash


current=$(light | cut -d '.' -f 1)

if [ $# -eq 1 ]; then
    change=1
else
    change="$2"
fi

if [ "$1" == "inc" ]; then
    opt="-A"
    new_value=$((current + change))
else
    opt="-U"
    new_value=$((current - change))
fi


if  [ "$current" == "100" ] && [ "$opt" == "-A" ]; then
    exit 0
elif [ "$current" == "0" ] && [ "$opt" == "-U" ]; then
    exit 0
fi

light "$opt" "$change"
dunstify "Brightness at ${new_value}%" -a "Backlight" -u low -h "int:value:$new_value" -h string:x-dunst-stack-tag:backlight
