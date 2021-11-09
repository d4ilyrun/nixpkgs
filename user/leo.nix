# ~/.config/nixpkgs/user/vmware.nix
{ config, pkgs, ... }:

let
  discord_url = https://discord.com/api/download?platform=linux&format=tar.gz;
in
{
  home.homeDirectory = "/home/leo";

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))

    (self: super: { discord = super.discord.overrideAttrs (_: { 
      src = builtins.fetchTarball discord_url; 
    });})
  ];

  imports = [
    ../programs/battery.nix
    ./packages/system.nix
    ./packages/fonts.nix
    ./packages/dev.nix
    ./packages/pie.nix
  ];

  programs.git = {
    enable = true;
    userEmail = "leo@duboin.com";
    userName = "Léo Duboin";
  };

}
