{ my, pkgs, ... }:

let
  dir = "${my.config.nixpkgs}/programs/polybar";

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

    config = with my.config.colorscheme; {
      "global/wm" = {
        margin-bottom = 0;
        margin-top = 0;
        margin-left = 2;
        margin-right = 2;
      };

      "bar/example" = {
        tray-position = "right";
        width =  "100%";
        height = 20;
        background = polybar.background;
        foreground = polybar.foreground;
        bottom = true;
        border-top-size = 2;
        border-bottom-size = 4;
        border-top-color = polybar.background;
        border-bottom-color = polybar.background;

        line-size = 1;
        wm-restack = "i3";

        modules-left = "i3";
        modules-center =  "";
        modules-right =  "";

        font-0 = "JetBrainsMono Nerd Font:style=Bold:pixelsize=11;3";
        font-1 = "Font Awesome 5 Free Solid:style=Solid:pixelsize=13";
      };
    };

    settings = with my.config.colorscheme; {
      "module/i3" = {
        type = "internal/i3";

        enable-click = true;
        enable-scroll = false;
        pin-workspaces = true;

        # TODO: change icons
        ws-icon-0 = "0;♚";
        ws-icon-1 = "1;♛";
        ws-icon-2 = "2;♜";
        ws-icon-3 = "3;♝";
        ws-icon-4 = "4;♞";
        ws-icon-default = "♟";

        format = "<label-state>";

        label-focused = "%icon%";
        label-focused-foreground= primary.foreground;

        label-unfocused = "\${self.label-focused}";
        label-unfocused-padding = 2;

        label-visible = "%icon%";
        label-visible-underline = normal.cyan;
        label-visible-padding = 2;

        label-urgent = "%icon%";
        label-urgent-underline = normal.red;
        label-urgent-padding = 2;

        label-separator = "|";
      };

      "settings" = {
        screenchange-reload = true;
      };
    };
  }

