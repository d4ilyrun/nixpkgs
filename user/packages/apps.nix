{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    feh
    dunst
    scrot
    firefox
    discord
    betterdiscordctl
    lxappearance
  ];
}


