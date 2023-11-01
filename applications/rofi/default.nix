{ config, pkgs, ... }:

let
  inherit (config.dotfiles.folders) applications;
  inherit (config.dotfiles.extraOptions) terminal;
  defaultTerminal = "${pkgs.alacritty}/bin/alacritty";
in
{
  programs.rofi = {
    enable = true;
    terminal = defaultTerminal;

    plugins = [
      pkgs.rofi-calc
      pkgs.rofi-emoji
    ];

    cycle = false;

    extraConfig = {
      modi = "drun,run,window,calc,emoji";
      font = "JetBrainsMono Nerd Font Medium 14";
      location = 0;

      drun-display-format = "{icon} {name}";
      display-window = " ";
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-Network = " 󰤨  Network";
      display-power = "Powermenu: ";

      show-icons = true;
      sidebar-mode = true;
      hide-scrollbar = true;
      disable-history = false;
    };

    theme = "${applications}/rofi/config.rasi";
  };

  xsession.windowManager.i3.config.keybindings = pkgs.lib.mkOptionDefault {
    "Mod4+d" = "exec rofi -show drun -show drun -show-icons -terminal ${terminal}";
    "Mod4+Shift+d" = "exec rofi -sho-icons -show window";
    "Mod4+Shift+e" = "exec ${import ./powermenu { inherit config pkgs; }}";
    "Mod4+Shift+c" = "exec rofi -show calc -modi calc -display-calc 󰃬 -terse | xsel -b";
    "Mod4+Shift+w" = "exec ${applications}/rofi/network/rofi-network-manager.sh";
    "Mod4+comma" = "exec rofi -modi emoji -show emoji -emoji-mode insert";
  };
}
