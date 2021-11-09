# ~/.config/nixpkgs/user/vmware.nix
{ config, pkgs, ... }:

{
  home.homeDirectory = "/home/leo";

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  imports = [
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
