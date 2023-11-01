{ config, pkgs, ... }:

let
  defaultTerminal = "${pkgs.alacritty}/bin/alacritty";
in
{
  programs.rofi = {
    enable = true;
    terminal = defaultTerminal;
    theme = "theme";

    plugins = [
      pkgs.rofi-calc
    ];

    extraConfig = {
      modi = "drun,run,window,calc";
      font = "JetBrainsMono Nerd Font Medium 13";

      display-window = " ";
      display-run = " ";
      display-drun = " ";
      display-power = "Powermenu: ";
      drun-display-format = " {name}";

      show-icons = true;
      sidebar-mode = false;
    };
  };

  xsession.windowManager.i3.config.keybindings = {
    "Mod4+Shift+c" = "exec rofi -show calc -modi calc -display-calc 󰃬 -terse | xsel -b";
  };
}
