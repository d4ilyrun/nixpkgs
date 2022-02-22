{ my, pkgs, lib, ... }:

with my.config.colorscheme;

let
  dir = "${my.config.nixpkgs}/programs/polybar";

  # Config HERE
  network_interface = "wlp0s20f3";
  # Find theses names with $ls -1 /sys/class/power_supply/
  battery_name = "BAT1";
  battery_adapter = "ACAD";
  monitor_name = "eDP-1";

  color = with normal; {
    inherit black red green yellow blue cyan white;
    foreground = primary.foreground;
    background = primary.background;
    purple = magenta;
  };
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

      "settings" = {
        screenchange-reload = true;
        pseudo-transparency = false;
        format-foreground = color.foreground;
        format-background = color.background;
      };

      "bar/example" = {
        width =  "100%";
        height = 22;
        padding-left = 1;
        padding-right = 2;
        bottom = false;

        background = color.background;
        foreground = color.foreground;

        border-top-size = 5;
        border-bottom-size = 3;
        border-top-color = color.background;
        border-bottom-color = color.background;

        line-size = 1;
        line-color = color.background;

        tray-position = "right";

        wm-restack = "i3";
        separator = "|";
        separator-foreground = color.foreground;
        enable-ipc = true;

        module-margin = 1;

        modules-left = "i3";
        modules-center =  "xwindow";
        modules-right =  "date powermenu";

        font-0 = "Iosevka:size=13;4";
        font-1 = "Feather:size=13;5";
        font-2 = "Material Icons:style=Regular:size=13;3";
        font-3 = "Font Awesome 5 Brands Regular:style=Regular:size=11";
        font-4 = "Font Awesome 5 Free Solid:style=Solid:size=11";
      };
    };

    settings = {
      "module/i3" = {
        type = "internal/i3";

        pin-workspace = true;

        ws-icon-0 = "0;";
        ws-icon-1 = "1;";
        ws-icon-2 = "2;";
        ws-icon-3 = "3;3";
        ws-icon-4 = "4;4";
        ws-icon-5 = "5;5";
        ws-icon-6 = "6;6";
        ws-icon-7 = "7;7";
        ws-icon-8 = "8;8";
        ws-icon-9 = "9;9";

        format = "<label-state><label-mode>";
        format-padding = 0;

        label-mode = "%mode%";
        label-mode-padding = 1;

        label-focused = "%icon%";
        label-focused-foreground = color.green;
        label-focused-underline =  color.green;
        label-focused-padding = 1;

        label-unfocused = "%icon%";
        label-unfocused-padding = 1;

        label-visible = "%icon%";
        label-visible-foreground = color.purple;
        label-visible-underline = color.purple;
        label-visible-padding = 1;

        label-urgent = "%icon%";
        label-urgent-foreground = color.red;
        label-urgen-padding = 1;
      };

      "module/powermenu" = {
        type = "custom/menu";
        expand-right = true;

        fomrat-margin = 1;
        format-spacing = 1;

        label-open = "%{T5}%{F${color.red}}%{O-3}";
        label-close = "Close";
        label-close-foreground = color.green;
        label-separator = "|";

        menu-0-0 = "Reboot";
        menu-0-0-exec = "systemctl reboot";
        menu-0-0-foreground = color.yellow;
        menu-0-1 = "Power off";
        menu-0-1-exec = "systemctl poweroff";
        menu-0-1-foreground = color.red;
      };
      
      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:25:...%";
      };

      "module/date" =  {
        type = "internal/date";
        interval = 1;

        format = "%{F${color.white}} %{F${color.foreground}}<label>";
        date = "";
        date-alt = "%d %b, %Y ";
        time = "%I:%M";
        time-alt = "%H:%M:%S";

        label = "%date%%time%";
      };
    };
  }

