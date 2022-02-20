# ~/.config/nixpkgs/home.nix
{ config, pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    news.display = "silent";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    imports = [
        ./machine/desktop.nix
        ./config/desktop
        ./user/leo.nix
    ];
}
