{ config, pkgs, my, ... }:

let
  my = import ../config/.;
  my_pkgs = import ./packages/overlays.nix;
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
