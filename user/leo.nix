{ config, pkgs, ... }:

let
  discord_url = https://discord.com/api/download?platform=linux&format=tar.gz;
in
{
  home = {
    homeDirectory = "/home/leo";
    sessionVariables = {
      PATH = "/home/leo/.npm-packages/bin/:$PATH";
      NIXOS_CONFIG="/home/leo/.config/nixpkgs/configuration.nix";
      NIXOS_CONFIG_DIR="/home/leo/.config/nixpkgs/";
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
    ../programs/battery.nix
    ./packages/system.nix
    ./packages/fonts.nix
    ./packages/dev.nix
    ./packages/apps.nix
    ./packages/pie.nix
  ];

  # HEAVY PACKAGES
  home.packages = with pkgs; [
    jetbrains.clion
  ];

  systemd.user.startServices = true;
}
