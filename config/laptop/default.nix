#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, gaps ? {}, ... }:

let
  my = import ../.;
  programs = "${my.config.nixpkgs}/programs";

  default_gaps = {
    inner = 5;
    outer = 5;
    smartGaps = false;
  };
in
{
  xsession.windowManager.i3 = lib.attrsets.recursiveUpdate (import "${programs}/i3/i3.nix" { inherit pkgs lib my; }) {
    config.gaps = default_gaps;
  };

  imports = [
    "${programs}/battery.nix"
    "${programs}/neovim"
    "${programs}/fish"
    "${programs}/rofi"
    (import "${programs}/awesome" { inherit my lib pkgs; })
    (import "${programs}/polybar" { inherit my pkgs lib; network = "wlp0s20f3"; })
    (import "${programs}/picom" { inherit pkgs; })
  ];

  # Standalone programs (don't need to download other configurations or change system-wide configurations)
  programs = {
    alacritty  = import "${programs}/alacritty/default-settings.nix" { inherit my pkgs; };
    firefox = import "${programs}/firefox" { inherit my pkgs lib; };
    spicetify = import "${programs}/spicetify";
    tmux = import "${programs}/tmux" { inherit pkgs my; };
  };

  services = {
    dunst = import "${programs}/dunst" { inherit my pkgs; };

    batteryNotifier = {
      enable = true;
      device = "BAT1";
    };
  };
}
