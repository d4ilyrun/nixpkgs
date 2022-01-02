{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # SCHOOL
    teams

    # ACDC
    # ocaml
    opam ocaml
    pkg-config
    bubblewrap
    xorg.libX11

    # CSharp
    dotnetCorePackages.sdk_5_0
    jetbrains.rider
  ]
  ++ ( with ocamlPackages; [
    graphics
    findlib
    batteries
    ocaml-lsp
  ]);
}

