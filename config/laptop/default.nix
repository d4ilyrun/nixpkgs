#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, ... }:

let
  programs = ../../programs;
in
{
  xsession.windowManager.i3 = import "${programs}/i3/i3.nix" { inherit pkgs lib; };

  programs = {
    neovim  = import "${programs}/neovim" { inherit pkgs; };
    alacritty  = import "${programs}/alacritty/default-settings.nix" { inherit pkgs; };
    fish = import "${programs}/fish";
    starship = import "${programs}/starship" { inherit lib; };
    rofi = import "${programs}/rofi" { inherit pkgs; };
  };

  services = {
    dunst = import "${programs}/dunst" { inherit pkgs; };
    polybar = import "${programs}/polybar" { inherit pkgs; };
  };
}
