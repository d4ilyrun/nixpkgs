{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # ACDC
    # ocaml
    opam ocaml
    pkg-config
    bubblewrap
    xorg.libX11
    ocamlPackages.graphics
    ocamlPackages.findlib
    ocamlPackages.batteries

    # C#
  ];
}

