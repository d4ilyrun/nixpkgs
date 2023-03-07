#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, ... }:

let
  inherit (config.dotfiles.folders) pkgs repository;
in
{
  # TODO: Make it only an additional set of options
  imports = [
    "${repository}/config/laptop"
    "${pkgs}/yaka.nix"
  ];
}
