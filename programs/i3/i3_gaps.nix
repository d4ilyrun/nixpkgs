{ pkgs, lib, ... }:

let
  wallpaper = "~/.wallpaper.jpg";
  browser = "firefox";
  term = "alacritty";

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

  colors = {
    background = "#2e3440";
    foreground = "#c0caf5";

    dark_black = "#1D202F";
    dark_red = "#f7768e";
    dark_green = "#9ece6a";
    dark_yellow = "#e0af68";
    dark_blue = "#7aa2f7";
    dark_purple = "#A569BD";
    dark_cyan = "#7dcfff";
    dark_grey = "#a9b1d6";

    light_black = "#4c546c";
    light_red = "#f7768e";
    light_green = "#9ece6a";
    light_yellow = "#e0af68";
    light_blue = "#7aa2f7";
    light_purple = "#bb9af7";
    light_cyan = "#7dcfff";
    light_grey = "#c0caf5";
  };
in
{
  
  enable = true;
  package = pkgs.i3-gaps;

  config = rec {
    modifier = "Mod4";
		
    window.border = 0;
		
    gaps = {
      inner = 8;
      outer = 0;
    };
    
    keybindings = lib.mkOptionDefault {
      "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
      "${modifier}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
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
      
      # Brightness
      "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 5";
      "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 5";

      # Audio
      "XF86AudioLowerVolume" = "exec \"amixer -q sset Master 1%-\"";
      "XF86AudioRaiseVolume" = "exec \"amixer -q sset Master 1%+\"";
      "XF86AudioMute" = "exec \"amixer -q sset Master toggle\"";

      # Applications
      "${modifier}+n" = "exec ${pkgs.${browser}}/bin/${browser}";
    };

    startup = [
      {
        command = "${pkgs.feh}/bin/feh --bg-scale ${wallpaper}";
        always = true;
        notification = false;
      }

      {
        command = "${pkgs.betterlockscreen}/bin/betterlockscreen -u ${wallpaper}";
        always = true;
        notification = false;
      }

      {
        command = "pkill i3bar polybar && ~/.config/polybar/launch.sh --forest";
        always = true;
      }

      {
        command = "${pkgs.i3-gaps}/bin/i3-msg workspace ${ws1}";
        always = false;
      }
    ];
  };

}
