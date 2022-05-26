{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        discord betterdiscordctl
        lazygit
        feh zathura

        # TODO: add to neovim's default.nix configuration
        # Switch to glbal imports instead of per-package
        # Or find a way to download packages some configs need directly from their config file
        ranger ueberzug highlight
    ];
}


