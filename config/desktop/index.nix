#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, ... }:

let
  programs = ../../programs;
in
{
  xsession.windowManager.i3 = import "${programs}/i3/i3_gaps.nix" { inherit pkgs lib; };

  programs = {
    alacritty = import "${programs}/terminal/alacritty/default-settings.nix" { inherit pkgs; };
    neovim  = import "${programs}/editor/neovim/default.nix" { inherit pkgs; };
    fish = import "${programs}/terminal/fish/default.nix";
  };
}
