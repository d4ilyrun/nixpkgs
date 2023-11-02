{ config, pkgs, lib, ... }:

let

  inherit (config.dotfiles.extraOptions.theme) flavour;

  cascadeCatppuccin = pkgs.stdenv.mkDerivation {
    name = "cascade";
    src = pkgs.fetchgit {
      url = "https://github.com/andreasgrafen/cascade.git";
      rev = "2f70e86";
      sha256 = "sha256-HOOBQ1cNjsDTFSymB3KjiZ1jw3GL16LF/RQxdn0sxr0=";
    };

    # Replace files as described in:
    # https://github.com/andreasgrafen/cascade#catppuccin
    installPhase = ''
      cp -r $src/* .
      chmod -R u+w .

      cp ./integrations/catppuccin/cascade-${flavour}.css ./chrome/includes/
      substituteInPlace ./chrome/userChrome.css  \
        --replace "colours" "${flavour}"

      cp -r ./chrome $out
    '';
  };

in

{
  home.file.".mozilla/firefox/${config.dotfiles.username}/chrome" = {
    enable = true;
    source = "${cascadeCatppuccin}";
    recursive = true;
  };
}
