{ pkgs, ... }:

let
  my = import ../../config;
  theme = "catpuccin";
  defaultTerminal = "${pkgs.alacritty}/bin/alacritty";
in
{
  xdg.configFile."rofi/${theme}.rasi".source = "${my.config.nixpkgs}/applications/rofi/${theme}.rasi";

  programs.rofi = {
    inherit theme;
    enable = true;
    terminal = defaultTerminal;

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
