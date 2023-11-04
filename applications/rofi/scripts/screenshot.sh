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
    rofi -dmenu -i \
        -theme-str 'window { width: 250; height: 0%; padding: 0; margin: 0; }' \
        -theme-str 'mainbox { height: 100%; width: 100%; }' \
        -theme-str 'listview { margin: 5px; }' \
        -only-match \
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
   choices=`cat<<EOF
󰆏 Region  Clip
󰆏 Screen  Clip
  Region  File
  Screen  File
EOF`

    choice=$(echo "$choices" | rofi_select_list)

    screen_type=$(echo "$choice" | cut -d ' ' -f2)
    save_type=$(echo "$choice" | cut -d ' ' -f4)

    if [ "$save_type" == "File" ]; then
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
        '󰆏 Region  Clip')
            screenshot_region | xclip -selection clipboard -t image/png
            notify_user "Selection copied to clipboard"
            ;;
        ' Region  File')
            screenshot_region "${save_file}"
            notify_user "Selection saved to ${save_file}"
            ;;
        '󰆏 Screen  Clip')
            maim | xclip -selection clipboard -t image/png
            notify_user "Screenshot copied to clipboard"
            ;;
        ' Screen  File')
            maim "${save_file}"
            notify_user "Screenshot saved to ${save_file}"
            ;;
    esac
}

main
