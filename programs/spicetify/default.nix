{ spicetify-nix, ... }:

# see https://github.com/the-argus/spicetify-nix/blob/master/README.md

{
  # import the flake's module for your system
  imports = [ spicetify-nix.homeManagerModule ];

  programs.spicetify.spicetifyPackage = spicetify-cli.overrideAttrs (oa: rec {
    pname = "spicetify-cli";
    version = "2.9.9";
    src = pkgs.fetchgit {
      url = "https://github.com/spicetify/${pname}";
      rev = "v${version}";
      sha256 = "1a6lqp6md9adxjxj4xpxj0j1b60yv3rpjshs91qx3q7blpsi3z4z";
    };
  });

  # configure spicetify :)
  programs.spicetify =
    {
      enable = true;
      theme = "catppuccin-mocha";
      colorScheme = "flamingo";

      enabledExtensions = [
        "fullAppDisplay.js"
        "hidePodcasts.js"
        "trashbin.js"
        "adblock.js"
        "fixEnhance.js"
        "autoSkip.js"
        "volumePercentage.js"
      ];

      enabledCustomApps = [
        "marketplace"
        "lyrics-plus"
        "new-releases"
        "reddit"
      ];
    };
}
