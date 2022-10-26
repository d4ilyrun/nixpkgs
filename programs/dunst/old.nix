{ my, pkgs, ... }:
let
  soundNotification = pkgs.writeScript "play-notification-sound.sh" ''
    #!/bin/sh
    ${pkgs.pulseaudio}/bin/paplay ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/window-attention.oga
  '';
in
{
  enable = true;
  settings = with my.config.colorscheme; {
    global = {
      ### DISPLAY ###
      geometry = "300x5-30+20";
      indicate_hidden = "yes";
      follow = "mouse";
      shrink = "no";

      notification_height = 0;
      separator_height = 2;
      separator_color = "frame";
      padding = 8;
      horizontal_padding = 8;

      frame_width = 2;
      frame_color = bright.white;

      sort = "yes";
      idle_threshold = 20;
      show_age_threshold = 60;

      stack_duplicate = "true";
      show_indicators = "yes";

      ### TEXT ###
      font = "Monospace 8";
      line_height = 0;
      markup = "full";
      format = "<b>%s</b>\n%b";
      alignment = "left";
      word_wrap = "yes";

      ### ICONS ###
      icon_position = "off";
      max_icon_size = 32;

      ### HISTORY ###
      sticky_history = "yes";
      history_length = 20;

      ### MISC ###
      dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst:";
      browser = "${pkgs.firefox}/bin/firefox -new-tab";
      mouse_left_click = "close_current";
      mouse_middle_click = "do_action";
      mouse_right_click = "close_all";
    };

    shortcuts = {
      close = "ctrl+space";
      close_all = "ctrl+shift+space";
    };

    urgency_low = {
      background = primary.background;
      foreground = primary.foreground;
      frame_width = 1;
      timeout = 10;
    };

    urgency_normal = {
      background = primary.background;
      foreground = primary.foreground;
      frame_color = bright.magenta;
      timeout = 10;
    };

    urgency_critical = {
      background = primary.background;
      foreground = primary.foreground;
      frame_color = bright.red;
      timeout = 0;
    };

    # Spotify = {
    #   appname="notify-send";
    #   skip_display = true;
    # };

    play_sound = {
      summary = "*";
      script = "${soundNotification}";
    };


    # Every section that isn't one of the above is interpreted as a rules to
    # override settings for certain messages.
    # Messages can be matched by "appname", "summary", "body", "icon", "category",
    # "msg_urgency" and you can override the "timeout", "urgency", "foreground",
    # "background", "new_icon" and "format".
    # Shell-like globbing will get expanded.
    #
    # SCRIPTING
    # You can specify a script that gets run when the rule matches by
    # setting the "script" option.
    # The script will be called as follows:
    #   script appname summary body icon urgency
    # where urgency can be "LOW", "NORMAL" or "CRITICAL".
    #
    # NOTE: if you don't want a notification to be displayed, set the format
    # to "".
    # NOTE: It might be helpful to run dunst -print in a terminal in order
    # to find fitting options for rules.

    #[espeak]
    #    summary = "*"
    #    script = dunst_espeak.sh

    #[script-test]
    #    summary = "*script*"
    #    script = dunst_test.sh

    #[ignore]
    #    # This notification will not be displayed
    #    summary = "foobar"
    #    format = ""

    #[signed_on]
    #    appname = Pidgin
    #    summary = "*signed on*"
    #    urgency = low
    #
    #[signed_off]
    #    appname = Pidgin
    #    summary = *signed off*
    #    urgency = low
    #
    #[says]
    #    appname = Pidgin
    #    summary = *says*
    #    urgency = critical
    #
    #[twitter]
    #    appname = Pidgin
    #    summary = *twitter.com*
    #    urgency = normal
    #
    # vim: ft=cfg


  };
}

