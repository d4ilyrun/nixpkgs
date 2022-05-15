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
    curl wget
    fzf tree
    killall
    htop
    tmux
    unzip
    xorg.xmodmap
    
    # Applications
    pulseaudio-ctl light
    dunst libnotify
    maim
    xsel xclip # clipboard

    # i3
    dmenu rofi
    betterlockscreen
  ];
}

