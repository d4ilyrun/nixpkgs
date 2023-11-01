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

  xsession.windowManager.i3.config.keybindings = pkgs.lib.mkOptionDefault {
    "Mod4+d" = "exec rofi -show drun -show drun -show-icons -terminal ${terminal}";
    "Mod4+Shift+d" = "exec rofi -sho-icons -show window";
    "Mod4+Shift+e" = "exec ${import ./powermenu { inherit config pkgs; }}";
    "Mod4+Shift+c" = "exec rofi -show calc -modi calc -display-calc 󰃬 -terse | xsel -b";
    "Mod4+Shift+w" = "exec ${applications}/rofi/network/rofi-network-manager.sh";
    "Mod4+comma" = "exec rofi -modi emoji -show emoji -emoji-mode insert";
  };
}
