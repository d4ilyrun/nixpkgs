{ my, pkgs, lib, ... }:

let
  wallpaper = my.wallpapers.comfy-home;

  browser = "${pkgs.firefox}/bin/firefox";
  term = "${pkgs.alacritty}/bin/alacritty";

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
  
  enable = true;
  package = pkgs.i3-gaps;

  config = rec {

    modifier = "Mod4";
    terminal = term;

    gaps = {
      inner = 3;
      outer = 3;
      smartGaps = true;
    };
    
    keybindings = lib.mkOptionDefault {
      "${modifier}+Return" = "exec ${term}";
      "${modifier}+d" = "exec rofi -show combi -show-icons";
      "${modifier}+Shift+q" = "kill";

      # Custom workspaces names
      "${modifier}+1" = "workspace ${ws1}";
      "${modifier}+Shift+1" = "move container to workspace ${ws1}";
      "${modifier}+2" = "workspace ${ws2}";
      "${modifier}+Shift+2" = "move container to workspace ${ws2}";
      "${modifier}+3" = "workspace ${ws3}";
      "${modifier}+Shift+3" = "move container to workspace ${ws3}";
      "${modifier}+4" = "workspace ${ws4}";
      "${modifier}+Shift+4" = "move container to workspace ${ws4}";
      "${modifier}+5" = "workspace ${ws5}";
      "${modifier}+Shift+5" = "move container to workspace ${ws5}";
      "${modifier}+6" = "workspace ${ws6}";
      "${modifier}+Shift+6" = "move container to workspace ${ws6}";
      "${modifier}+7" = "workspace ${ws7}";
      "${modifier}+Shift+7" = "move container to workspace ${ws7}";
      "${modifier}+8" = "workspace ${ws8}";
      "${modifier}+Shift+8" = "move container to workspace ${ws8}";
      "${modifier}+9" = "workspace ${ws9}";
      "${modifier}+Shift+9" = "move container to workspace ${ws9}";
      "${modifier}+0" = "workspace ${ws0}";
      "${modifier}+Shift+0" = "move container to workspace ${ws0}";

      # Lock
      "${modifier}+Shift+x" = "exec betterlockscreen -l dimblur";
      
      # Screenshot
      "Print" = "exec scrot -e 'mv $f ~/Images/Screenshots/'";
      "${modifier}+Print" = "exec scrot -ub -e 'mv $f ~/Images/Screenshots/'";
      "${modifier}+Shift+s" = "exec scrot -e 'mv $f ~/Images/Screenshots/'";
      
      # TODO: xbacklight
      # Brightness
      "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 5";
      "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 5";

      # Audio
      "XF86AudioLowerVolume" = "exec \"amixer -q sset Master 10%-\"";
      "XF86AudioRaiseVolume" = "exec \"amixer -q sset Master 10%+\"";
      "XF86AudioMute" = "exec \"amixer -q sset Master toggle\"";

      # Applications
      "${modifier}+n" = "exec ${browser}";
    };

    modes.resize = {
      Left = "resize shrink width 3 px or 3 ppt";
      Down = "resize grow height 3 px or 3 ppt";
      Up = "resize shrink height 3 px or 3 ppt";
      Right = "resize grow width 3 px or 3 ppt";

      Escape = "mode \"default\"";
    };

    bars = [
      # { statusCommand = "${pkgs.i3blocks}/bin/i3blocks -c ~/.config/nixpkgs/programs/i3blocks/config"; }
    ];

    window.border = 3;

    colors = with my.config.colorscheme; {
      background = primary.background;

      focused = {
        background = primary.background;
        text = primary.foreground;
        border = primary.background;
        childBorder = normal.magenta;
        indicator = normal.magenta;
      };

      unfocused = {
        background = primary.background;
        text = primary.foreground;
        border = primary.background;
        childBorder = primary.background;
        indicator = normal.magenta;
      };
    };

    startup = [
      { command = "${pkgs.feh}/bin/feh --bg-scale ${wallpaper}"; always = true; }
      { command = "${pkgs.betterlockscreen}/bin/betterlockscreen -u ${wallpaper}"; always = true; }
      { command = "${pkgs.i3-gaps}/bin/i3-msg workspace ${ws1}"; always = false; }
      { command = "systemctl --user restart polybar"; always = true; }
      { command = "${pkgs.autorandr}/bin/autorandr -c"; always = false; }
    ];
  };
}
