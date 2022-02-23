#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, gaps ? {}, ... }:

let
  my = import ../.;
  programs = "${my.config.nixpkgs}/programs";

  default_gaps = {
    inner = 3;
    outer = 3;
    smartGaps = true;
  };
in
{
  xsession.windowManager.i3 = lib.attrsets.recursiveUpdate (import "${programs}/i3/i3.nix" { inherit pkgs lib my; }) {
    config.gaps = default_gaps;
  };

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
    firefox = import "${programs}/firefox" { inherit my pkgs lib; };
    tmux = import "${programs}/tmux" { inherit pkgs my; };
  };

  services = {
    dunst = import "${programs}/dunst" { inherit my pkgs; };
    polybar = import "${programs}/polybar" { inherit my pkgs lib; };

    batteryNotifier = {
      enable = true;
    };
  };
}
