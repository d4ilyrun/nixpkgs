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
        height = 25;
        padding-left = 1;
        padding-right = 2;
        bottom = false;

        background = color.background;
        foreground = color.foreground;

        border-top-size = 5;
        border-bottom-size = 0;
        border-top-color = color.background;
        border-bottom-color = color.background;

        line-size = 2;
        line-color = color.background;

        tray-position = "right";

        wm-restack = "i3";
        separator = "|";
        separator-foreground = color.foreground;
        enable-ipc = true;

        module-margin = 1;

        modules-left = "nixos i3";
        modules-center =  "xwindow";
        modules-right =  "date powermenu";

        font-0 = "Iosevka:size=13;1";
        font-1 = "Iosevka:size=6;1";
        font-2 = "Font Awesome 5 Free Solid:style=Solid:size=12";
        font-3 = "Font Awesome 5 Brands Regular:style=Regular:size=12";
        font-4 = "Material Icons:style=Solid:size=13";
        font-5 = "FiraCode Nerd Font:style=Retina,Regular:size=13";
        font-6 = "Font Awesome 5 Free Regular:style=Solid:size=12";
      };
    };

    settings = {
      "module/i3" = {
        type = "internal/i3";

        pin-workspace = true;

        ws-icon-0 = "0;ﭮ";
        ws-icon-1 = "1;";
        ws-icon-2 = "2;";
        ws-icon-3 = "3;";
        ws-icon-default = " ";

        format = "<label-state>";
        format-margin = 0;

        label-focused = "%icon%:%name% ";
        label-focused-foreground = color.green;

        label-unfocused = "%icon%:%name% ";

        label-visible = "%icon%:%name% ";
        label-visible-foreground = color.purple;

        label-urgent = "%icon%:%name% ";
        label-urgent-foreground = color.red;
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

      "module/nixos" = {
        type = "custom/text";

        content = "";
        content-foreground = color.cyan;
      };
    };
  }

