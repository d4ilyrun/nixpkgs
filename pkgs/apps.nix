{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    discord
    betterdiscordctl
    lazygit
    feh
    zathura
    thunderbird
    birdtray
    libnotify

    # TODO: add to neovim's default.nix configuration
    # Switch to glbal imports instead of per-package
    # Or find a way to download packages some configs need directly from their config file
    ranger
    ueberzug
    highlight
  ];
}


