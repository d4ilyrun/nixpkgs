{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    slack
    # clockify # INSECURE
    thunderbird
    nodejs
    pkgs.pyright
  ];
}


