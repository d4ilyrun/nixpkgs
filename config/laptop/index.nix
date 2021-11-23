#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, ... }:

let
  programs = ../../programs;
in
{
  xsession.windowManager.i3 = import "${programs}/i3/i3.nix" { inherit pkgs lib; };

  programs = {
    neovim  = import "${programs}/neovim/default.nix" { inherit pkgs; };
    alacritty  = import "${programs}/alacritty/default-settings.nix" { inherit pkgs; };
    fish = import "${programs}/fish/default.nix";
    starship = import "${programs}/starship/default.nix" { inherit lib; };
    rofi = import "${programs}/rofi/default.nix" { inherit pkgs; };
  };

  services = {
    dunst = import "${programs}/dunst/default.nix" { inherit pkgs; };
  };
}
