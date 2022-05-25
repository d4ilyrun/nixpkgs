{ my, pkgs }:

let
  spicetify-overlay = (self: super: {
    spotify-unwrapped = super.callPackage "${my.config.nixpkgs}/pkgs/overlays/spicetify.nix" {
      inherit (super) spotify-unwrapped;
      config = {
        theme = "Glaze";
        colorScheme = "base";

        extensions = [
          (builtins.fetchUrl "https://raw.githubusercontent.com/CharlieS1103/spicetify-extensions/main/adblock/adblock.js")
          (builtins.fetchUrl "https://raw.githubusercontent.com/CharlieS1103/spicetify-extensions/main/songstats/songstats.js")
        ];
      };
    };
  });
in
{
  # Add spicetify as an overlay of spotify-unwrapped
  nixpkgs.overlays = [ spicetify-overlay ];
  home.packages = [ pkgs.spotify-unwrapped ];
}
