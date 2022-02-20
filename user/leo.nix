{ config, pkgs, my, ... }:

let
  discord_url = https://discord.com/api/download?platform=linux&format=tar.gz;
  my = import ../config/.;
in
{
  home = {
    homeDirectory = my.config.home;
    sessionVariables = rec {
      PATH = "${my.config.home}/.npm-packages/bin/:$PATH";
    };
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))

    (self: super: { discord = super.discord.overrideAttrs (_: { 
      src = builtins.fetchTarball discord_url; 
    });})
  ];

  imports = [
    # Packages
    ./packages/system.nix
    ./packages/dev.nix
    ./packages/apps.nix
    ./packages/school.nix
    ./packages/acdc.nix

    # Fonts
    ./packages/fonts.nix
  ];

  # HEAVY PACKAGES
  home.packages = with pkgs; [
      jetbrains.clion
  ];

  systemd.user.startServices = true;
}
