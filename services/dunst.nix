{ config, pkgs, lib, ... }:
let
  soundNotification = pkgs.writeShellApplication {
    name = "play_sound";
    runtimeInputs = [ pkgs.pulseaudio ];
    text = ''
      #!/bin/sh
      ${pkgs.pulseaudio}/bin/paplay ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/window-attention.oga
    '';
  };

  inherit (lib) mkOverridable;

in
{
  home.packages = [
    pkgs.pulseaudio
  ];

  services.dunst = {

    enable = true;

    settings = with config.dotfiles.theme.colors; {
      global = {

        # --- Display --- #

        # The monitor to be displayed to
        monitor = 0;
        follow = "none";

        width = 300;
        # height = 260;
        origin = "top-right";
        offset = "30x60";

        # default colors
        frame_color = mkOverridable primary.accent;
        separator_color = mkOverridable "frame";

        progress_bar = "true";
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;


        # Show how many messages are hidden
        indicate_hidden = "yes";

        # Shrink window if it's smaller than the width.
        shrink = "no";

        # The transparency of the window.
        transparency = 1;

        # Draw a line between multiple notifications
        separator_height = 4;

        # Set notification padding
        padding = 16;
        horizontal_padding = 16;

        # Disable frame (border)
        frame_width = 1;

        # Sort messages by urgency.
        sort = "no";

        # Disable idle time
        idle_threshold = 0;


        # --- Text --- #

        # Set the font
        # font = Noto Sans 11"";
        font = "Fira Nerd Font 11";

        # Set line height to font height
        line_height = 0;

        # Reference for markup and formatting:
        #  <b>bold</b>
        #  <i>italic</i>
        #  <s>strikethrough</s>
        #  <u>underline</u>
        #  <https://developer.gnome.org/pango/stable/pango-Markup.html>.
        #  %a appname
        #  %s summary
        #  %b body
        #  %i iconname (including its path)
        #  %I iconname (without its path)
        #  %p progress value if set ([  0%] to [100%]) or nothing
        #  %n progress value if set without any extra characters
        #  %% Literal %

        markup = "full";
        format = "<b>%a</b>\n%s";

        # Left align the text
        alignment = "left";

        # Vertical alignment of message text and icon.
        vertical_alignment = "center";

        # Show age of message if message is old
        show_age_threshold = 120;

        # Wrap text if it doesn't fit in geometry
        word_wrap = "yes";

        # Where to place ellipses if word wrap is disabled
        # ellipsize = "middle";

        # Use newlines '\n' in notifications.
        ignore_newline = "no";

        # Don't stack together notifications
        stack_duplicates = "false";

        # Hide the count of stacked notifications
        # hide_duplicate_count = "false";

        # Display indicators for URLs (U) and actions (A).
        show_indicators = "yes";


        # ---- Icons ---- #

        # Align icons left/right/off
        icon_position = "left";

        # Scale small icons up to this size, set to 0 to disable.
        min_icon_size = 60;

        # Scale larger icons down to this size, set to 0 to disable
        max_icon_size = 60;

        # Paths to default icons.
        icon_path = "/home/kai/.icons/Reversal-blue/apps/scalable:/usr/share/icons/Adwaita/256x256/legacy/";


        # --- History --- #

        # Avoid timing out hidden notifications
        sticky_history = "yes";

        # Maximum amount of notifications kept in history
        history_length = 100;


        # --- Misc/Advanced --- #

        dmenu = "${pkgs.dmenu}/bin/dmenu -p dunst:";

        # Browser for opening urls in context menu.
        browser = "${pkgs.firefox}/bin/firefox -new-tab";

        # Always run rule-defined scripts, even if the notification is suppressed
        always_run_script = "false";

        # Define the title of the windows spawned by dunst
        title = "Dunst";

        # Define the class of the windows spawned by dunst
        class = "Dunst";

        # Define the corner radius of the notification window
        corner_radius = 0;

        # Don't gnore the dbus closeNotification message.
        ignore_dbusclose = "false";


        # --- Legacy --- #

        # Use the Xinerama extension instead of RandR for multi-monitor support.
        force_xinerama = "false";

        # --- Mouse --- #
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };

      shortcuts = {
        close = "alt+space";
        close_all = "alt+shift+space";
      };

      # Colors are overridable if defined elsewhere (insidethe theme config for example)

      urgency_low = mkOverridable {
        background = primary.background;
        foreground = primary.foreground;
        highlight = primary.accent;
        timeout = 8;
      };

      urgency_normal = mkOverridable {
        background = primary.background;
        foreground = primary.foreground;
        frame_color = primary.foreground;
        timeout = 8;
      };

      urgency_critical = mkOverridable {
        background = primary.background;
        foreground = primary.foreground;
        frame_color = normal.red;
        timeout = 0;
        icon = "abrt";
      };

      # Spotify = {
      #   appname="notify-send";
      #   skip_display = true;
      # };

      play_sound = {
        summary = "nothing"; # TODO select only important ones
        script = "${soundNotification}/bin/play_sound";
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
  };
}

