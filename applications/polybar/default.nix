{ config
, pkgs
, lib
, ...
}:

with config.dotfiles.theme.colors;

let

  inherit (lib) existsOr;

  dir = "${config.dotfiles.folders.applications}/polybar";

  # Config HERE
  # Find theses names with $ls -1 /sys/class/power_supply/
  my_battery = existsOr config.dotfiles.extraOptions "battery" {
    battery = "BAT1";
    adapter = "ACAD";
  };

  network = existsOr config.dotfiles.extraOptions "network" "wlan0";

  color = with normal; {
    inherit black red green yellow blue cyan white;
    foreground = primary.foreground;
    background = primary.background;
    purple = magenta;
  };
in
{
  home.packages = [ ];

  services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      pulseSupport = true;
      iwSupport = true;
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
        width = "100%";
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

        modules-left = "nixos i3 xwindow";
        modules-center = "mpris-tail";
        modules-right = "kb pulseaudio alsa battery wireless-network filesystem date";

        font-0 = "Iosevka:size=13;1";
        font-1 = "Iosevka:size=6;1";
        font-2 = "Unifont:style=Regular,Regular:size=13";
        font-3 = "Font Awesome 5 Free Solid:style=Solid:size=12";
        font-4 = "Font Awesome 5 Brands Regular:style=Regular:size=12";
        font-5 = "Material Design Icons:style=Solid:size=13";
        font-6 = "Fira Code Nerd Font:style=Retina,Regular:size=13";
        font-7 = "Font Awesome 5 Free Regular:style=Solid:size=12";
      };
    };

    settings = {
      "module/i3" = {
        type = "internal/i3";

        pin-workspace = true;

        ws-icon = [ "0; " "1;" "2; " "3; " "9;󰒱" ];
        ws-icon-default = " ";

        format = "<label-state>";
        format-margin = 0;

        label = {
          # Use font 7 for icons
          unfocused = "%{T-6}%icon%%{T-}:%name% ";
          focused = { text = "%{T-6}%icon%%{T-}:%name% "; foreground = color.green; };
          visible = { text = "%{T-6}%icon%%{T-}:%name% "; foreground = color.purple; };
          urgent = { text = "%{T-6}%icon%%{T-}:%name% "; foreground = color.red; };
        };
      };

      "module/powermenu" = {
        type = "custom/text";
        content = "%{O-3}";
        format-spacing = 1;
        click-left = "rofi -modi 'Powermenu:~/.config/nixpkgs/applications/polybar/scripts/powermenu.sh' -show Powermenu";
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:25:...%";
        label-foreground = bright.black;
      };

      "module/date" = {
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

      "module/wireless-network" =
        let
          rofi = "${config.dotfiles.folders.applications}/rofi";
          nmcli-polybar = pkgs.writeShellApplication {
            name = "nmcli-polybar";
            text = "${rofi}/network/rofi-network-manager.sh";
          };
        in
        {
          type = "internal/network";
          interface = network;

          interval = 3.0;

          #format-connected = "%{T7}<ramp-signal>%{T-}<label-connected>";
          label-connected = "%essid%";
          format-connected = "%{T7}<ramp-signal>%{T-} %{A2:${nmcli-polybar}/bin/nmcli-polybar:}<label-connected>%{A}";
          format-connected-foreground = color.green;
          format-connected-underline = color.green;
          label-connected-foreground = color.green;

          label-connected-alt = "%essid%%downspeed:9%";

          ramp-signal = [
            { text = ""; foreground = color.green; }
            { text = "直"; foreground = color.green; }
            { text = "睊"; foreground = color.red; }
          ];

          label-disconnected = " not connected";
          format-disconnected = "%{A1:${nmcli-polybar}/bin/nmcli-polybar:}<label-disconnected>%{A}";
          format-disconnected-foreground = color.red;
          format-disconnected-underline = color.red;
        };

      "module/filesystem" = {
        type = "internal/fs";
        mount-0 = "/";

        format-mounted = "<label-mounted>";
        fixed-values = true;

        label.mounted = { text = " %free%"; foreground = color.yellow; underline = color.yellow; };
      };

      "module/battery" = rec {
        type = "internal/battery";
        full-at = 99;
        low-at = 15;

        inherit (my_battery) battery adapter;

        format-charging = "<animation-charging> <label-charging>";
        format-discharging = "<ramp-capacity> <label-discharging>";
        format-low = "<animation-discharging> <label-low>";
        format-full = " <label-full>";

        label-charging = "%percentage%%";
        label-discharging = label-charging;
        label-low = "BATTERY LOW";
        label-full = "Full";

        format = rec {
          charging = { foreground = color.cyan; underline = charging.foreground; };
          discharging = { foreground = charging.foreground; underline = charging.foreground; };
          full = { foreground = charging.foreground; underline = charging.foreground; };
        };

        label = {
          low = rec { text = "BATTERY LOW"; foreground = color.red; underline = foreground; };
        };

        animation-charging = [ "" "" "" "" "" ];
        animation-charging-framerate = 750;

        ramp-capacity = animation-charging;

        animation-low-0 = "";
        animation-low-1 = " ";
        animation-low-framerate = 200;
      };

      "module/mpris-tail" =
        let
          mpris-python = pkgs.python3.withPackages (p: with p; [
            dbus-python
            pygobject3
            gst-python
          ]);
          mpris = pkgs.writeShellApplication {
            name = "mpris";
            runtimeInputs = [ mpris-python ];
            text = "${dir}/scripts/player-mpris-tail.py";
          };
        in
        {
          type = "custom/script";
          exec = "${mpris}/bin/mpris -f '{icon} {:artist:t5:{artist}:}{:artist: - :}{:t4:{title}:}'";
          tail = true;

          click-left = "${mpris}/bin/mpris previous &";
          click-right = "${mpris}/bin/mpris next &";
          click-middle = "${mpris}/bin/mpris play-pause &";
        };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        use-ui-max = true;

        format = {
          muted = rec {
            text = "󰸈<label-muted>";
            foreground = color.red;
            underline = foreground;
          };
          volume = rec {
            text = "<ramp-volume><label-volume>";
            foreground = color.cyan;
            underline = foreground;
          };
        };

        label.muted = { text = "Muted"; foreground = color.red; };

        ramp.volume = [ " " " " "󰕾" ];
      };

      "module/kb" = {
        type = "internal/xkeyboard";
        blacklist = [ ];

        format = { text = "<label-indicator> <label-layout>"; foreground = bright.black; };

        label = {
          layout = { text = "%icon%"; };
          indicator = { text = "%icon%"; };
        };

        layout.icon = [
          "fr;AZERTY"
          "fr;bepo;BEPO"
        ];

        indicator.icon = [
          "caps lock;;󰘶"
          "num lock;;󰎠"
        ];
      };
    };
  };
}
