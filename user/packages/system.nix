{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  home.packages = with pkgs; [
    # CLI/terminal
    alacritty fish
    wget curl
    htop neofetch
    killall
    fzf tree
    
    # Applications
    feh
    light
    dunst
    rofi
    scrot

    # i3
    dmenu
    picom
    polybar
    betterlockscreen
  ];
}

