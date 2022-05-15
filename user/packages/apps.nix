{ config, pkgs, ... }:

let
  spicetify = fetchTarball https://github.com/pietdevries94/spicetify-nix/archive/master.tar.gz;
in
{
    imports = [ (import "${spicetify}/module.nix") ];

    home.packages = with pkgs; [
        firefox
        discord betterdiscordctl
        spotify-unwrapped
        lazygit
        feh zathura

        # TODO: add to neovim's default.nix configuration
        # Switch to glbal imports instead of per-package
        # Or find a way to download packages some configs need directly from their config file
        ranger ueberzug highlight
    ];
}


