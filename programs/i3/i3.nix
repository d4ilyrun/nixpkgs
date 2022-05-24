{ my, pkgs, lib, my_gaps }:

let
  wallpaper = my.config.wallpaper;
  wallpaper_2 = my.wallpapers.vertical.anime.koucha_bench; # wallpaper for second screen

  browser = "${pkgs.firefox}/bin/firefox";
  term = "${pkgs.alacritty}/bin/alacritty";

  scripts = "${my.config.nixpkgs}/programs/i3/scripts";
  volume = "bash ${scripts}/volume.sh";
  light = "bash ${scripts}/backlight.sh";
  screenshot = "bash ${scripts}/screenshot.sh";

  ws1 = "1";
  ws2 = "2";
  ws3 = "3";
  ws4 = "4";
  ws5 = "5";
  ws6 = "6";
  ws7 = "7";
  ws8 = "8";
  ws9 = "9";
  ws0 = "0";
in
{ 
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {

      modifier = "Mod4";
      terminal = term;

      gaps = my_gaps;
      defaultWorkspace = ws1;

      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${term}";
        "${modifier}+d" = "exec rofi -show drun -show drun -show-icons -terminal ${term}";
        "${modifier}+Shift+d" = "exec rofi -sho-icons -show window";
        "${modifier}+Shift+w" = "exec ${my.config.nixpkgs}/programs/rofi/network/rofi-network-manager.sh";
        "${modifier}+Shift+q" = "kill";

        # Rofi menu selection
        "${modifier}+e" = "exec EDITOR='/usr/bin/env nvim' alacritty -e ranger"; # file explorer
          "${modifier}+Shift+e" = "exec rofi -modi 'Powermenu:~/.config/nixpkgs/programs/polybar/scripts/powermenu.sh' -show Powermenu";
        "${modifier}+comma" = "exec rofi -show-emoji";

        # Custom workspaces names
        "${modifier}+1" = "workspace ${ws1}";
        "${modifier}+2" = "workspace ${ws2}";
        "${modifier}+3" = "workspace ${ws3}";
        "${modifier}+4" = "workspace ${ws4}";
        "${modifier}+5" = "workspace ${ws5}";
        "${modifier}+6" = "workspace ${ws6}";
        "${modifier}+7" = "workspace ${ws7}";
        "${modifier}+8" = "workspace ${ws8}";
        "${modifier}+9" = "workspace ${ws9}";
        "${modifier}+0" = "workspace ${ws0}";
        "${modifier}+Shift+1" = "move container to workspace ${ws1}";
        "${modifier}+Shift+2" = "move container to workspace ${ws2}";
        "${modifier}+Shift+3" = "move container to workspace ${ws3}";
        "${modifier}+Shift+4" = "move container to workspace ${ws4}";
        "${modifier}+Shift+5" = "move container to workspace ${ws5}";
        "${modifier}+Shift+6" = "move container to workspace ${ws6}";
        "${modifier}+Shift+7" = "move container to workspace ${ws7}";
        "${modifier}+Shift+8" = "move container to workspace ${ws8}";
        "${modifier}+Shift+9" = "move container to workspace ${ws9}";
        "${modifier}+Shift+0" = "move container to workspace ${ws0}";
        "${modifier}+Shift+h" = "move scratchpad";

        # Lock
        "${modifier}+Shift+x" = "exec betterlockscreen -l dimblur";

        # Screenshot
        "Shift+Print" = "exec --no-startup-id maim --select \"${my.config.home}/Images/Screenshots/$(date)\"";
        # Clipboard Screenshot
        "Print" = "exec --no-startup-id maim | xclip -selection clipboard -t image/png";
        "${modifier}+Print" = "exec --no-startup-id maim --window $(xdotool getactivewindow) | xclip -selection clipboard -t image/png";
        "${modifier}+Shift+s" = "exec --no-startup-id maim --select | xclip -selection clipboard -t image/png";

        # Light
        "XF86MonBrightnessUp" = "exec ${light} dec";
        "XF86MonBrightnessDown" = "exec ${light} inc";
        "Shift+XF86MonBrightnessUp" = "exec ${light} dec 1";
        "Shift+XF86MonBrightnessDown" = "exec ${light} inc 1";

        # Audio
        "XF86AudioLowerVolume" = "exec ${volume} down";
        "XF86AudioRaiseVolume" = "exec ${volume} up";
        "XF86AudioMute" = "exec ${volume} mute";
        "Shift+XF86AudioLowerVolume" = "exec ${volume} down 1";
        "Shift+XF86AudioRaiseVolume" = "exec ${volume} up 1";
        "Shift+XF86AudioMute" = "exec ${volume} mute";

        # Play/Pause
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";

        # Hide/Show polybar
        "${modifier}+Shift+BackSpace" = "exec polybar-msg cmd toggle";

        # Applications
        "${modifier}+n" = "exec ${browser}";
      };

      modes.resize = {
        Left = "resize shrink width 5 px or 5 ppt";
        Down = "resize grow height 5 px or 5 ppt";
        Up = "resize shrink height 5 px or 5 ppt";
        Right = "resize grow width 5 px or 5 ppt";

        ShiftUp = "resize shrink height 2 px or 2 ppt";
        ShiftDown = "resize grow height 2 px or 2 ppt";
        ShiftLeft = "resize shrink width 2 px or 2 ppt";
        ShiftRight = "resize grow width 2 px or 2 ppt";

        Escape = "mode \"default\"";
      };

      window.border = 3;

      assigns = {
        "${ws0}" = [ 
        { class = "Spotify"; }
        { class = "discord"; }
        ];
      };

      colors = with my.config.colorscheme; {
        background = primary.background;

        focused = {
          background = primary.background;
          text = primary.foreground;
          border = primary.background;
          childBorder = primary.accent;
          indicator = primary.accent;
        };

        unfocused = {
          background = primary.background;
          text = primary.foreground;
          border = primary.background;
          childBorder = primary.background;
          indicator = primary.background;
        };
      };

      bars = [];

      startup = [
      { command = "${pkgs.feh}/bin/feh --bg-fill ${wallpaper} ${wallpaper_2}"; always = true; }
      { command = "${pkgs.betterlockscreen}/bin/betterlockscreen -u ${wallpaper}"; always = true; }
      { command = "${pkgs.autorandr}/bin/autorandr -c"; always = false; }
      { command = "bash ${scripts}/capslock_remap.sh"; always = true; }
      { command = "systemctl --user restart polybar"; always = true; }
      ];
    };
  };
}
