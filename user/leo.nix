{ config, pkgs, my, ... }:

let
  my = import ../config;
  my_pkgs = import "${my.config.nixpkgs}/pkgs/overlays";
in
{
  home = {
    homeDirectory = my.config.home;
    sessionVariables = rec {
      PATH = "${my.config.home}/.npm-packages/bin/:$PATH";
      EDITOR = "nvim";
    };

    keyboard = {
      layout = "fr,fr";
      variant = ",bepo";
      options = "eurosign:e,grp:win_space_toggle";
    };
  };

  nixpkgs = with my_pkgs; {
    inherit overlays;
    config.packageOverrides = pkgs: {
      nur = import overrides.nur { inherit pkgs; };
    };
  };

  imports = with my.config; [
    # Packages
    "${nixpkgs}/pkgs/system.nix"
    "${nixpkgs}/pkgs/dev.nix"
    "${nixpkgs}/pkgs/apps.nix"
    "${nixpkgs}/pkgs/school.nix"
    "${nixpkgs}/pkgs/acdc.nix"

    # Fonts
    "${nixpkgs}/pkgs/fonts.nix"
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
