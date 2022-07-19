{ my, pkgs }:

let
  spicetify-overlay = (self: super: {
    spotify-unwrapped = super.callPackage "${my.config.nixpkgs}/pkgs/overlays/spicetify.nix" {
      inherit (super) spotify-unwrapped;
      config = {
        theme = "Default";
        colorScheme = "ocean";

        extensions = [
          (builtins.fetchUrl "https://raw.githubusercontent.com/CharlieS1103/spicetify-extensions/main/adblock/adblock.js")
          (builtins.fetchUrl "https://raw.githubusercontent.com/daksh2k/Spicetify-stuff/master/Extensions/fullScreen.js")
        ];
      };
    };
  });

  spicetify = fetchTarball https://github.com/pietdevries94/spicetify-nix/archive/master.tar.gz;
in
{
  # Add spicetify as an overlay of spotify-unwrapped
  nixpkgs.overlays = [ spicetify-overlay ];
  home.packages = [ pkgs.spotify-unwrapped ];

  #imports = [ (import "${spicetify}/module.nix") ];
  #
  #programs.spicetify = {
  #  enable = true;
  #  theme = "Dribbblish";
  #  colorScheme = "dracula";
  #  enabledExtensions = [ "fullAppDisplay.js" "newRelease.js" ];
  #};
}
