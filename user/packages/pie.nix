{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # ACDC
    # ocaml
    opam ocaml
    pkg-config
    bubblewrap
    xorg.libX11

    # CSharp
    dotnet-netcore
    dotnet-sdk
  ]
  ++ ( with ocamlPackages; [
    graphics
    findlib
    batteries
    ocaml-lsp
  ]);
}

