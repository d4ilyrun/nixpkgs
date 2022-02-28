let
  discord_url = https://discord.com/api/download?platform=linux&format=tar.gz;
in
[
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))

    (self: super: { discord = super.discord.overrideAttrs (_: { 
      src = builtins.fetchTarball discord_url; 
    });})
]
