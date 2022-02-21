#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, ... }:

let
  my = import ../.;
  programs = "${my.config.nixpkgs}/programs";
in
{
  xsession.windowManager.i3 = import "${programs}/i3/i3.nix" { inherit pkgs lib my; };

  imports = [
    "${programs}/battery.nix"
    "${programs}/neovim"
  ];

  programs = {
    alacritty  = import "${programs}/alacritty/default-settings.nix" { inherit my pkgs; };
    fish = import "${programs}/fish" {inherit my; };
    starship = import "${programs}/starship" { inherit lib; };
    rofi = import "${programs}/rofi" { inherit my pkgs; };
    git = import "${programs}/git" { inherit my pkgs; };
    spicetify = import "${programs}/spicetify";
  };

  services = {
    dunst = import "${programs}/dunst" { inherit my pkgs; };
    polybar = import "${programs}/polybar" { inherit my pkgs lib; };

    batteryNotifier = {
      enable = true;
    };
  };
}
