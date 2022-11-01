{ my, pkgs, ... }:

let
  dir = "${my.config.nixpkgs}/applications/polybar";

  # Config HERE
  network_interface = "wlp0s20f3";
  # Find theses names with $ls -1 /sys/class/power_supply/
  battery_name = "BAT1";
  battery_adapter = "ACAD";
  monitor_name = "eDP-1";
in
{
  enable = true;

  package = pkgs.polybar.override {
    i3GapsSupport = true;
    alsaSupport = true;
  };

  script = ''
    killall -q polybar
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
    echo "" > /tmp/polybar.log
    PATH=$PATH:${pkgs.i3}/bin polybar example >> /tmp/polybar.log 2>&1 &
  '';

  config = {
    "global/wm" = {
      margin-bottom = 0;
      margin-top = 0;
    };

    "bar/example" = {
      tray-position = "right";
      width = "100%";
      height = 20;
      padding-left = 1;
      padding-right = 1;
      background = "\${colors.background}";
      foreground = "\${colors.foreground}";
      bottom = false;
      border-top-size = 5;
      border-bottom-size = 2;
      border-top-color = "\${colors.background}";
      border-bottom-color = "\${colors.background}";

      line-size = 1;
      wm-restack = "i3";

      modules-left = "i3";
      modules-center = "alsa";
      modules-right = "round-left battery round-right alsa round-left cpu round-right temperature spaces round-left mem round-right backlight-acpi round-left wlan time round-right sysmenu";

      font-0 = "JetBrainsMono Nerd Font:style=Bold:pixelsize=11;3";
      font-1 = "JetBrainsMono Nerd Font:size=15;3";
      font-2 = "Material Icons:style=Regular:size=13;3";
      font-3 = "unifont:fontformat=truetype:size=13:antialias=true";
      font-4 = "Iosevka Nerd Font:pixelsize=10;3";
      font-5 = "Font Awesome 5 Free Solid:style=Solid";
    };
  };

  settings = {
    "module/mpd" = {
      type = "internal/mpd";
      interval = 2;
      format-online = "<icon-prev><toggle><icon-next>";
      icon-play-foreground = "\${colors.color1}";
      icon-play = "󰐊 ";
      icon-pause-foreground = "\${colors.color1}";
      icon-pause = "󰏥 ";
      icon-stop-foreground = "\${colors.color1}";
      icon-stop = "󰓛 ";
      icon-prev-foreground = "\${colors.color4}";
      icon-prev = "󰒮 ";
      icon-next-foreground = "\${colors.color4}";
      icon-next = "󰒭 ";
      icon-play-underline = "\${colors.color3}";
      icon-next-underline = "\${colors.color5}";
      icon-pause-underline = "\${colors.color3}";
      icon-prev-underline = "\${colors.color3}";
    };

    "module/xwindow" = {
      type = "internal/xwindow";
      label = "%title:0:64:...%";
    };

    "module/alsa" = {
      type = "internal/alsa";
      format-volume = "<label-volume> <bar-volume> ";
      label-volume = " ";
      label-volume-foreground = "\${colors.colors8}";

      format-muted-foreground = "\${colors.foreground}";
      label-muted = "󰚙";

      format-muted-padding = 1;
      format-muted-background = "#2b2f37";

      bar-volume-width = 10;
      bar-volume-foreground-0 = "#61afef";
      bar-volume-foreground-1 = "#61afef";
      bar-volume-foreground-2 = "#61afef";
      bar-volume-foreground-3 = "#61afef";
      bar-volume-foreground-4 = "#61afef";
      bar-volume-foreground-5 = "#61afef";
      bar-volume-foreground-6 = "#61afef";
      bar-volume-gradient = true;
      bar-volume-indicator = "";
      bar-volume-indicator-foreground = "#e06c75";
      bar-volume-indicator-font = 1;
      bar-volume-fill = "  ";
      bar-volume-fill-foreground = "#61afef";
      bar-volume-fill-font = 1;
      bar-volume-empty = " ";
      bar-volume-empty-font = 1;
      bar-volume-empty-foreground = "\${colors.foreground}";
      format-volume-padding = 1;
    };

    "module/temperature" = {
      type = "internal/temperature";
      thermal-zone = 0;
      warn-temperature = 65;
      label-foreground = "\${colors.color7}";
      format = "<ramp> <label>";
      format-underline = "#b48ead ";
      format-warn = "<ramp>  <label-warn>";
      format-warn-underline = "#b48ead";
      format-background = "\${colors.color8}";

      label = "%{F#e06c75} %temperature-c%";
      label-warn = "%temperature-c%";
      label-warn-backgroud = "#b48ead";
      format-padding = 0;
      ramp-0 = "󰸁  ";
      ramp-foreground = "\${colors.color11}";
    };

    "module/window" = {
      type = "custom/script ";
      exec = "${dir}/scripts/window.sh 2>/dev/null";
      interval = 1;
      format = "<label> ";
      label = "%output% ";
      label-padding = 1;
    };

    "module/polywins" = {
      type = "custom/script";
      exec = "${dir}/scripts/polywins.sh 2>/dev/null";
      format = "<label>";
      label = "%output%";
      label-padding = 1;
      tail = true;
      label-background = "\${colors.color8}";
    };

    "module/spaces" = {
      type = "custom/text";
      content = "%{T3} %{T-}";
    };

    "module/i3" = {
      type = "internal/i3";

      enable-click = true;
      enable-scroll = true;
      reverse-scroll = true;

      format = "<label-state> <label-mode>";

      label-mode-padding = 2;
      label-mode-background = "\${colors.color8}";
      label-mode-foreground = "\${colors.color2}";

      label-focused = "%index%";
      label-focused-background = "\${colors.color8}";
      label-focused-underline = "#61afef";
      label-focused-padding = 1;

      label-unfocused = "%index%";
      label-unfocused-background = "\${colors.background}";
      label-unfocused-padding = 1;

      label-visible = "%index%";
      label-visible-background = "\${self.label-focused-background}";
      label-visible-underline = "\${colors.color1}";
      label-visible-padding = 1;

      label-urgent = "%index%";
      label-urgent-underline = "\${colors.color5}";
      label-urgent-padding = 1;
    };

    "module/round-left" = {
      type = "custom/text";
      content = "%{T2}%{T-}";
      content-foreground = "#2b2f37";
    };

    "module/round-right" = {
      type = "custom/text";
      content = "%{T2}%{T-}";
      content-foreground = "#2b2f37";
    };

    "module/time" = {
      type = "internal/date";
      interval = 60;

      format = "<label>";
      format-background = "\${colors.color8} ";

      date = "%{F#57b6c2} %{F-}%{F#abb2bf}%H:%M%{F-}";
      time-alt = "%{F#56b6c2}  %{F-}%{F#abb3bf}%a, %b %d%{F-}";

      label = "%date%%time%";
    };

    "module/sysmenu" = {
      type = "custom/text ";
      content = " ";
      content-foreground = "\${colors.color13}";
      content-padding = 1;
      click-left = "${dir}/scripts/powermenu.sh";
    };

    "module/xbacklight" = {
      type = "internal/xbacklight";
      format = "<label>";
      format-prefix = "  ";
      label = "%{F#e5c07b}%percentage%";
      format-prefix-foreground = "#e5c07b";
      label-foreground = "#abb2bf";
      format-padding = 1;
    };

    "module/backlight-acpi" = {
      "inherit" = "module/xbacklight";
      type = "internal/backlight";
      card = "intel_backlight";
    };

    "module/wlan" = {
      type = "internal/network";
      interface = network_interface;
      interval = 3;
      format-connected = "<label-connected>";
      label-connected = "  ";
      label-connected-foreground = "\${colors.color4}";
      label-disconnected = "睊 ";
      label-disconnedted-foreground = "\${colors.color4} ";
      label-connected-background = "\${colors.color8}";
      label-disconnected-bacoground = "\${colors.color8}";
    };

    "module/cpu" = {
      type = "internal/cpu";
      interval = 2.5;

      format = "<label> ";
      format-padding = 1;
      format-margin = 0;

      label = "%{F#99c47a}  %{F-}%percentage%%";
      format-background = "\${colors.color8}";
      format-foreground = "\${colors.color7}";
    };

    "module/memory" = {
      type = "internal/memory";
      interval = 2;
      format-prefix = " ";
      format-prefix-foreground = "\${colors.foreground-alt}";
      format-underline = "#00000000";
      label = "%percentage_used%%";
    };

    "module/xkeyboard" = {
      type = "internal/xkeyboard";
      label-layout = "%layout%";
    };

    "module/network" = {
      type = "internal/network";
      interface = network_interface;
      interval = 3;

      format-connected = "<ramp-signal> <label-connected>";
      format-connected-underline = "#00000000";
      label-connected = " %essid%";

      format-disconnected = "<label-disconnected>";
      format-disconnected-underline = "\${colors.color1}";
      label-disconnected = "xx.xx.xx.xx";
      label-disconnected-foreground = "\${colors.foreground-alt}";

      ramp-signal-0 = "";
      ramp-signal-1 = "";
      ramp-signal-2 = "";
      ramp-signal-3 = "";
      ramp-signal-4 = "";
      ramp-signal-foreground = "\${colors.foreground-alt}";
    };

    "module/date" = {
      type = "internal/date";
      interval = 5;

      date = "";
      date-alt = " %Y-%m-%d";

      time = "%I:%M %p";
      time-alt = "%H:%M:%S";

      format-prefix = "";
      format-prefix-foreground = "\${colors.foreground-alt}";
      format-underline = "#00000000";

      label = "%date% %time%";
    };

    "module/powermenu" = {
      type = "custom/menu";

      format-spacing = 1;

      label-open = "";
      label-open-foreground = "\${colors.foreground-alt}";
      label-close = "cancel";
      label-close-foreground = "\${colors.foreground-alt}";
      label-separator = "|";
      label-separator-foreground = "\${colors.foreground-alt}";

      menu-0-0 = "reboot";
      menu-0-0-exec = "menu-open-1";
      menu-0-1 = "power off";
      menu-0-1-exec = "menu-open-2";

      menu-1-0 = "cancel";
      menu-1-0-exec = "menu-open-0";
      menu-1-1 = "reboot";
      menu-1-1-exec = "reboot";

      menu-2-0 = "power off";
      menu-2-0-exec = "poweroff";
      menu-2-1 = "cancel";
      menu-2-1-exec = "menu-open-0";
    };


    "module/battery" = {
      type = "internal/battery";

      full-at = 100;

      battery = battery_name;
      adapter = battery_adapter;
      poll-interval = 5;

      format-charging = "<animation-charging> <label-charging>";
      label-charging = "%percentage%%";
      format-charging-foreground = "\${colors.color4}";
      format-charging-background = "\${colors.color8}";

      format-discharging = "<ramp-capacity> <label-discharging>";
      label-discharging = "%percentage%%";
      format-discharging-foreground = "\${colors.foreground}";
      format-discharging-background = "\${colors.color8}";

      label-full = "Fully charged";
      format-full-prefix = " ";
      format-full-prefix-foreground = "\${colors.color4}";
      format-foreground = "\${colors.color4}";
      format-background = "\${colors.color8}";

      # Only applies if <ramp-capacity> is used
      ramp-capacity-0 = "";
      ramp-capacity-1 = "";
      ramp-capacity-2 = "";
      ramp-capacity-3 = "";
      ramp-capacity-4 = "";
      ramp-capacity-foreground = "\${colors.foreground}";

      # Only applies if <bar-capacity> is used
      bar-capacity-width = 10;

      # Only applies if <animation-charging> is used
      animation-charging-0 = "";
      animation-charging-1 = "";
      animation-charging-2 = "";
      animation-charging-3 = "";
      animation-charging-4 = "";
      animation-charging-foreground = "\${colors.color4}";
      # Framerate in milliseconds
      animation-charging-framerate = 750;
    };

    "settings" = {
      screenchange-reload = true;
    };

    "colors" = with my.config.colorscheme; {
      background = normal.black;
      foreground = primary.foreground;
      color0 = normal.black;
      color1 = normal.red;
      color2 = normal.green;
      color3 = normal.yellow;
      color4 = normal.blue;
      color5 = normal.magenta;
      color6 = normal.cyan;
      color7 = normal.white;
      color8 = bright.black;
      color9 = bright.red;
      color10 = bright.green;
      color11 = bright.yellow;
      color12 = bright.blue;
      color13 = bright.magenta;
      color14 = bright.cyan;
      color15 = bright.white;
      dark-light = normal.magenta;
      active-light = normal.blue;
      foreground-alt = normal.magenta;
    };
  };
}

