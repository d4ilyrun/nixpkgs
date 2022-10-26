{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # ocaml
    opam
    ocaml
    pkg-config
    bubblewrap
    xorg.libX11

    # CSharp
    jetbrains.rider
    dotnetCorePackages.sdk_5_0
    dotnetCorePackages.runtime_5_0
  ]
  ++ (with ocamlPackages; [
    graphics
    findlib
    batteries
    ocaml-lsp
  ]);
}

