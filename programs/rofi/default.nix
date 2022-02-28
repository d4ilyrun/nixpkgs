{ pkgs, ... }:

let
  my = import ../../config;
  theme = "dmenu";
  defaultTerminal = "${pkgs.alacritty}/bin/alacritty";
in
  {
    xdg.configFile."rofi/${theme}.rasi".source = "${my.config.nixpkgs}/programs/rofi/${theme}.rasi";
    xdg.configFile."rofi/powermenu.rasi".source = "${my.config.nixpkgs}/programs/rofi/powermenu.rasi";

    programs.rofi = {
      inherit theme;
      enable = true;
      terminal = defaultTerminal;

      extraConfig = {
        modi = "drun,run,window";
        font = "JetBrainsMono Nerd Font Medium 13";

        display-window = "";
        display-run = "";
        display-drun = "";
        drun-display-format = "{name}";
        
        show-icons = true;
        sidebar-mode = false;
      };

    };
  }
