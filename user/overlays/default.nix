let
  discord_url = https://discord.com/api/download?platform=linux&format=tar.gz;
in
{
  overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))

    (self: super: {
      discord = super.discord.overrideAttrs (_: { src = builtins.fetchTarball discord_url; });

      miru = super.callPackage ./miru.nix { inherit (super); };

      spotify-unwrapped = super.callPackage ./spicetify.nix {
        inherit (super) spotify-unwrapped;
        config = {
          theme = "Glaze";
          colorScheme = "base";
          extensions = [ (builtins.fetchUrl "https://raw.githubusercontent.com/CharlieS1103/spicetify-extensions/main/adblock/adblock.js") ];
        };
      };
    })
  ];

  overrides = {
    nur = builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz";
  };
}
