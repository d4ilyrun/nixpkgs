#!/usr/env  bash

setxkbmap -model pc104 -layout fr,fr -variant ,bepo -option grp:win_space_toggle
setxkbmap -option caps:backspace
setxkbmap -option shift:both_capslock
xmodmap -e "clear Lock"
