{ config, pkgs, my, ... }:

let
  my = import ../config;
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

  programs = {
    git = import "${my.config.nixpkgs}/programs/git" { inherit my pkgs; };
  };

  systemd.user.startServices = true;
}
