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
    killall
    starship
    htop neofetch
    fzf tree
    file
    
    # Applications
    feh
    dunst libnotify
    scrot

    # i3
    dmenu
    rofi
    polybar
    betterlockscreen
  ];
}

