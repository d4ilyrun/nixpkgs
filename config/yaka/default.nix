#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, ... }:

let
  my = import ../.;
  nixpkgs = my.config.nixpkgs;
  programs = "${nixpkgs}/applications";
in
{
  imports = [
    "${nixpkgs}/config/laptop"
    "${nixpkgs}/pkgs/yaka.nix"
  ];
}
