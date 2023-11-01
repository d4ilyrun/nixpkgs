{ pkgs, spicetify-nix, ... }:

# see https://github.com/the-argus/spicetify-nix/blob/master/README.md

{
  # import the flake's module for your system
  imports = [ spicetify-nix.homeManagerModule ];

  home.packages = [ pkgs.go ];

  # configure spicetify :)
  programs.spicetify = {

    enable = true;

    spicetifyPackage = pkgs.spicetify-cli.overrideAttrs (oa: rec {
      pname = "spicetify-cli";
      version = "2.25.3";
      src = pkgs.fetchgit {
        url = "https://github.com/spicetify/${pname}";
        rev = "v${version}";
        sha256 = "sha256-xEikizbHK32vnldP0jBEOtNwG/R2KpkS9dX4eMabh2E=";
      };
      vendorSha256 = pkgs.lib.fakeSha256;
    });

    theme = pkgs.spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    enabledExtensions = with pkgs.spicePkgs.extensions; [
      fullAppDisplay
      hidePodcasts
      trashbin
      adblock
      autoSkip
      volumePercentage
    ];

    enabledCustomApps = with pkgs.spicePkgs.apps; [
      marketplace
      lyrics-plus
      new-releases
      reddit
    ];
  };
}
