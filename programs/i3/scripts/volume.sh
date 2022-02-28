#!/usr/bin/env bash

ctl=$(which pulseaudio-ctl)
iconDir="$3" # to change


getIcon() {
    status=$("$ctl" full-status)
    vol=$(echo "$status" | cut -d ' ' -f1)
    mute=$(echo "$status" | cut -d ' ' -f2)
    #echo $vol

    if [ "$mute" == "yes" ]; then
        echo "$iconDir/volume-level-muted.svg"
    else
        if [ "$vol" -eq 0 ]; then
            echo "$iconDir/volume-level-none.svg"
        elif [ "$vol" -lt 33 ]; then
            echo "$iconDir/volume-level-low.svg"
        elif [ "$vol" -lt 66 ]; then
            echo "$iconDir/volume-level-medium.svg"
        else
            echo "$iconDir/volume-level-high.svg"
        fi
    fi
}


$ctl $@
current=$("$ctl" current | tr -d '%')
#dunstify -i "$(getIcon)" -u low -h string:x-dunst-stack-tag:volume -a "Volume" "Volume at $current" -h "int:value:${current}"
dunstify -u low -h string:x-dunst-stack-tag:volume -a "Volume" "Volume at $current" -h "int:value:${current}"


