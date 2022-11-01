{ pkgs, ... }:

let
  my = import ../../config;
in
{
  xdg.configFile."ranger".source = "${my.config.nixpkgs}/applications/ranger";
}
