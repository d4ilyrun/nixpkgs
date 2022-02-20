{ config, pkgs, ... }:

let
  spicetify = fetchTarball https://github.com/pietdevries94/spicetify-nix/archive/master.tar.gz;
in
{
    imports = [ (import "${spicetify}/module.nix") ];

    home.packages = with pkgs; [
        firefox
        lxappearance
        discord betterdiscordctl
        spotify-unwrapped
    ];
}


