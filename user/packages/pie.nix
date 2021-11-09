{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # ACDC
    opam ocaml
    pkg-config
    xorg.libX11
    bubblewrap
    ocamlPackages.graphics
    ocamlPackages.findlib
    ocamlPackages.batteries
    (python39.withPackages (ps: with ps; [
      pip
      setuptools
      click
    ]))
  ];
}

