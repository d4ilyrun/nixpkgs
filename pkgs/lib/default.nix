{ pkgs, lib, stdenv, ... }:

let
  inherit (lib) attrsets;
in

rec {
  buildFirefoxXpiAddon = { name, url, sha256, addonId }:
    pkgs.stdenv.mkDerivation {

      inherit name;

      src = builtins.fetchurl { inherit url sha256; };

      preferLocalBuild = true;
      allowSubstitutes = true;

      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$src" "$dst/${addonId}.xpi"
      '';
    };

  existsOr = set: attr: orValue:
    if attrsets.hasAttrByPath [ attr ] set then
      attrsets.getAttr attr set
    else
      orValue
  ;

  importConfig = imports:
    (map (service: "${../../services}/${service}.nix") (existsOr imports "services" [ ]))
    ++ (map (app: "${../../applications}/${app}") (existsOr imports "applications" [ ]))
    ++ (map (pkg: "${../../pkgs}/${pkg}.nix") (existsOr imports "pkgs" [ ]))
    ++ (existsOr imports "imports" [ ])
  ;
}
