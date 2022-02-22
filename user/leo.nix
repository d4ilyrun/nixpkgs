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

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
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

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "ranger.desktop" ]; # Default file manager
    };
  };

  systemd.user.startServices = true;

}
