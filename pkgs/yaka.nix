{ config, pkgs, ... }:

let
  unstable = import <unstable> {};
in
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    slack
    #clockify
    thunderbird
  ];
}


