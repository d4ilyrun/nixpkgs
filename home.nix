# ~/.config/nixpkgs/home.nix
{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./machine/desktop.nix
    ./user/leo.nix
    ./config/laptop
  ];
}
