{ my, pkgs, lib, ... }:

with my.config.colorscheme;

let
  dir = "${my.config.nixpkgs}/programs/polybar";

  # Config HERE
  network_interface = "wlp35s0";
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
        modules-right =  "wireless-network filesystem date";

        font-0 = "Iosevka:size=13;1";
        font-1 = "Iosevka:size=6;1";
        font-2 = "Unifont:style=Regular,Regular:size=13";
        font-3 = "Font Awesome 5 Free Solid:style=Solid:size=12";
        font-4 = "Font Awesome 5 Brands Regular:style=Regular:size=12";
        font-5 = "Material Icons:style=Solid:size=13";
        font-6 = "FiraCode Nerd Font:style=Retina,Regular:size=13";
        font-7 = "Font Awesome 5 Free Regular:style=Solid:size=12";
      };
    };

    settings = {
      "module/i3" = {
        type = "internal/i3";

        pin-workspace = true;

        ws-icon-0 = "0;";
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
        type = "custom/text";
        content = "%{O-3}";
        format-spacing = 1;
        click-left = "rofi -modi 'Powermenu:~/.config/nixpkgs/programs/polybar/scripts/powermenu.sh' -show Powermenu";
      };
      
      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:25:...%";
      };

      "module/date" =  {
        type = "internal/date";
        interval = 1;

        format = "%{T7} %{T-}<label>";
        format-foreground = color.purple;
        format-underline = color.purple;

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

      "module/wireless-network" = {
        type = "internal/network";
        interface = network_interface;

        interval = 3.0;

        format-packetloss = "%{T7}<ramp-signal>%{T-}<label-connected>";

        label-connected = "%downspeed:9%";
        label-connected-foreground = color.green;
        label-connected-underline = color.green;

        label-connected-alt = "%essid%%downspeed:9%";

        ramp-signal-0 = "";
        ramp-signal-0-foreground = color.green;
        ramp-signal-1 = "直";
        ramp-signal-1-foreground = color.yellow;
        ramp-signal-2 = "睊";
        ramp-signal-2-foreground = color.red;

        label-disconnected = " not connected";
        label-disconnected-foreground = color.red;
        label-disconnected-underline = color.red;
      };

      "module/filesystem" = {
        type = "internal/fs";
        mount-0 = "/";

        format-mounted = "<label-mounted>";
        fixed-values = true;

        label-mounted = " %free%";
        label-mounted-foreground = color.yellow;
        label-mounted-underline = color.yellow;
      };
    };
  }

