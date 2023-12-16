#!/usr/bin/env bash

screenshot_directory="${XDG_PICTURES_DIR:-$HOME/Images}/Screenshots"
existing_screenshots=$(find "$screenshot_directory" -type f -exec basename {} \;)

function rofi_chose_name() {
    rofi -dmenu -markup -p "name" \
        -mesg "Saved into: <i>${screenshot_directory}</i>
 <i>Press 'Tab' to use a selected filename</i>" \
        -kb-element-next "" -kb-row-select 'Tab' \
        -format f
}

function rofi_select_list() {
    rofi -dmenu \
        -theme-str "window {width: 670px;}" \
        -theme-str "listview {columns: 5; lines: 1;}" \
        -theme-str 'textbox-prompt-colon {str: " ";}' \
        -theme "screenshot" \
        -markup-rows \
        "$@"
}

function screenshot_region() {
    notify_user "Select a region to capture"
    maim --select "$@" # Caller can pass additional arguments to maim
}

function notify_user() {
    notify-send --app-name="screenshot" "Screenshot" "$@"
}

function main() {
    select_clip='󰆞'
    screen_clip=''
    select_file='󰩭'
    screen_file='󰍹'

    choices=`echo -e "$select_clip\n$screen_clip\n$select_file\n$screen_file"`
    choice=$(echo "$choices" | rofi_select_list -p "Screenshot" -mesg "DIR: ${screenshot_directory}")

    screen_type=$(echo "$choice" | cut -d ' ' -f2)
    save_type=$(echo "$choice" | cut -d ' ' -f4)

    if [ "$choice" == "$select_file" ] || [ "$choice" == "$screen_file" ]; then
        save_file=$(echo -e "$existing_screenshots" | rofi_chose_name)
        save_file="${screenshot_directory}/${save_file}" # TODO: default extension ?
    fi

    if [ "$save_file" == "${screenshot_directory}/" ]; then
        notify_user "Empty filename" --urgency=critical
        exit 1
    fi


    # Prevent having the rofi window appear on our screen
    sleep 1

    case "$choice" in
        "$select_clip")
            screenshot_region | xclip -selection clipboard -t image/png
            notify_user "Selection copied to clipboard"
            ;;
        "$select_file")
            screenshot_region "${save_file}"
            notify_user "Selection saved to ${save_file}"
            ;;
        "$screen_clip")
            maim | xclip -selection clipboard -t image/png
            notify_user "Screenshot copied to clipboard"
            ;;
        "$screen_file")
            maim "${save_file}"
            notify_user "Screenshot saved to ${save_file}"
            ;;
    esac
}

main
