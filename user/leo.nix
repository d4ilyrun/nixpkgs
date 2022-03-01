{ config, pkgs, my, ... }:

let
  my = import ../config/.;
in
{
  home = {
    homeDirectory = my.config.home;
    sessionVariables = rec {
      PATH = "${my.config.home}/.npm-packages/bin/:$PATH";
      EDITOR = "nvim";
    };
  };

  nixpkgs = {
    overlays = import ./packages/overlays.nix;
    config.packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };
  };

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

  programs = {
    git = import "${my.config.nixpkgs}/programs/git" { inherit my pkgs; };
  };

  systemd.user.startServices = true;

}
