#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, ... }:

let
  programs = ../../programs;
in
{
  xsession.windowManager.i3 = import "${programs}/i3/i3.nix" { inherit pkgs lib; };

  programs = {
    alacritty = {
      enable = true;
      settings = lib.attrsets.recursiveUpdate (import "${programs}/terminal/alacritty/default-settings.nix") {
        live_config_reload = true;
        shell = {
          program = "${pkgs.fish}/bin/fish";
          args = [ "-C" "neofetch" ];
        };
      };
    };

    neovim  = import "${programs}/editor/neovim/default.nix" { inherit pkgs; };
    fish = import "${programs}/terminal/fish/default.nix";
  };
}
