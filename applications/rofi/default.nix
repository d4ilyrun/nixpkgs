{ config, pkgs, ... }:

let
  defaultTerminal = "${pkgs.alacritty}/bin/alacritty";
in
{
  programs.rofi = {
    enable = true;
    terminal = defaultTerminal;
    theme = "theme";

    extraConfig = {
      modi = "drun,run,window";
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
}
