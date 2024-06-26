{ config, pkgs, lib, ... }:

let

  inherit (config.dotfiles) homeDirectory extraOptions;
  inherit (config.dotfiles.theme) wallpapers;
  inherit (config.dotfiles.folders) applications;
  inherit (config.dotfiles.extraOptions) browser terminal;

  wallpaper = builtins.head wallpapers.active;

  scripts = "${applications}/i3/scripts";
  volume = "bash ${scripts}/volume.sh";
  light = "bash ${scripts}/backlight.sh";
  screenshot = "bash ${scripts}/screenshot.sh";

  # Rofi
  powermenu = import "${applications}/rofi/powermenu" { inherit config pkgs; };

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
      inherit terminal;

      defaultWorkspace = "workspace number ${ws1}";

      keybindings = lib.mkOptionDefault {

        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Shift+r" = "restart";
        "${modifier}+Shift+q" = "kill";

        # file explorer
        "${modifier}+e" = "exec EDITOR='/usr/bin/env nvim' ${terminal} -e ranger";

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
        "${modifier}+BackSpace" = "move scratchpad";

        # Vim keybindings to move between windows
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";


        # Switch modes
        "${modifier}+f" = "fullscreen";
        "Ctr+Shift+r" = "mode resize";
        "Ctr+Shift+s" = "layout stacking";
        "Ctr+Shift+t" = "layout tabbed";
        "Ctr+Shift+d" = "layout default";
        "Ctrl+Shift+f" = "floating toggle";

        # Lock
        "${modifier}+Shift+x" = "exec i3lock -i ${config.dotfiles.homeDirectory}/.wallpaper";

        # Screenshot
        "Print" = "exec --no-startup-id maim --window $(xdotool getactivewindow) | xclip -selection clipboard -t image/png";

        # Light
        "XF86MonBrightnessUp" = "exec ${light} inc 5";
        "XF86MonBrightnessDown" = "exec ${light} dec 5";
        "Shift+XF86MonBrightnessUp" = "exec ${light} inc 10";
        "Shift+XF86MonBrightnessDown" = "exec ${light} dec 10";

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

      window = {
        border = 3;

        commands = [
          { command = "border pixel 3"; criteria = { class = "Google-chrome"; }; }
          { command = "border pixel 3"; criteria = { class = "Alacritty"; }; }
          { command = "border pixel 3"; criteria = { class = "^.*"; }; }
        ];
      };

      assigns = {
        "${ws3}" = [{ class = "firefox"; }];
        "${ws0}" = [{ class = "Spotify"; }];
        "${ws9}" = [
          { class = "discord"; }
          { class = "Slack"; }
        ];
      };

      # Assign workspaces to second monitor, if any
      workspaceOutputAssign = lib.lists.optionals (lib.attrsets.hasAttrByPath [ "extraOptions" "monitor" "secondary" ] config.dotfiles) (
        with extraOptions.monitor; [
          {
            workspace = "${ws2}";
            output = secondary;
          }
          {
            workspace = "${ws3}";
            output = secondary;
          }
        ]
      );

      colors = with config.dotfiles.theme.colors; {
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

      bars = [ ];

      startup = [
        { command = "birdtray"; }
        { command = "${pkgs.feh}/bin/feh --bg-fill ${lib.concatStringsSep " " wallpapers.active}"; always = true; }
        { command = "${pkgs.betterlockscreen}/bin/betterlockscreen -u ${wallpaper}"; always = true; }
        { command = "${pkgs.autorandr}/bin/autorandr -c"; always = false; }
        { command = "bash ${scripts}/capslock_remap.sh"; always = true; }
        { command = "systemctl --user restart polybar"; always = true; }
        { command = "setxkbmap -layout fr,fr -variant ,bepo_afnor -option grp:win_space_toggle,eurosigne:e"; always = true; }
        { command = "${pkgs.xorg.xset}/bin/xset r rate 280 60"; always = true; }
      ];
    };
  }; # // lib.mkIf (config.dotfiles.extraOptions ? i3) config.dotfiles.extraOptions;
}
