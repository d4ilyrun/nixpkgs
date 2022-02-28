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
    curl
    killall
    htop
    fzf tree
    tmux
    
    # Applications
    pulseaudio-ctl light
    dunst libnotify
    scrot

    # i3
    dmenu rofi
    betterlockscreen
  ];
}

