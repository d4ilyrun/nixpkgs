{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # CLI/terminal
    alacritty
    fish
    curl
    wget
    fzf
    tree
    killall
    htop
    tmux
    unzip
    xorg.xmodmap

    # Applications
    pulseaudio-ctl
    light
    dunst
    libnotify
    maim
    xsel
    xclip # clipboard
    playerctl

    # i3
    dmenu
    rofi
    betterlockscreen
  ];
}

