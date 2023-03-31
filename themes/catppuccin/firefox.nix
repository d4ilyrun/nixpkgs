{ config, pkgs, lib, ... }:

let

  inherit (config.dotfiles.extraOptions.theme) flavour accent;

  cascadeCatppuccin = pkgs.stdenv.mkDerivation {
    name = "cascade";
    src = pkgs.fetchgit {
      url = "https://github.com/andreasgrafen/cascade.git";
      rev = "467c8df";
      sha256 = "6czuf+lXjAhP3LlyT1tDDtlEf6tTuADgWwad6vaDW3s=";
    };

    # Replace files as described in:
    # https://github.com/andreasgrafen/cascade#catppuccin
    installPhase = ''
      mkdir -p $out

      cp ./integrations/catppuccin/*.css ./chrome/includes

      substituteInPlace ./chrome/userChrome.css  \
        --replace "colours" "${flavour}" \
        --replace "includes/cascade-colours" "$out/chrome/includes/"

      cp -r * $out
    '';
  };

in

{
  programs.firefox = {

    extensions = [
      (lib.buildFirefoxXpiAddon {
        name = "catpppuccin-theme";
        url = "https://github.com/catppuccin/firefox/releases/download/old/catppuccin_${flavour}_${accent}.xpi";
        sha256 = "1v8av2y7czh422khk1icb1r03djiw2kpdai81glsv5h14zv6a7w6";
        addonId = "{5b78178f-135d-4df2-821f-1f289be7f348}";
      })
    ];

    profiles = {
      "${config.dotfiles.username}" = {
        userChrome = builtins.readFile "${cascadeCatppuccin}/chrome/userChrome.css";
      };
    };

  };
}
