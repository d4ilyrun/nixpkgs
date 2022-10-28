#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, ... }:

let
  my = import ../.;
  nixpkgs = my.config.nixpkgs;
  programs = "${nixpkgs}/programs";

  modifier = "Mod4";
  primary = "eDP-1-1";
  secondary = "HDMI-0";

  my_gaps = {
    inner = 6;
    smartGaps = false;
  };
in
{
  imports = [
    # Packages
    "${nixpkgs}/pkgs/system.nix"
    "${nixpkgs}/pkgs/dev.nix"
    "${nixpkgs}/pkgs/apps.nix"
    "${nixpkgs}/pkgs/school.nix"

    # Fonts
    "${nixpkgs}/pkgs/fonts.nix"

    # Minimal configuration
    ../minimal

    # TODO: change it to an import function
    "${programs}/battery.nix"

    (import "${programs}/spicetify" { inherit my pkgs; })
    (import "${programs}/polybar" { inherit my pkgs lib; network = "wlp0s20f3"; })
    (import "${programs}/i3/i3.nix" { inherit my pkgs lib my_gaps; })
  ];

  # Standalone programs (don't need to download other configurations or change system-wide configurations)
  programs = {
    autorandr = import "${programs}/autorandr/laptop.nix";
  };

  home.packages = with pkgs; [
    # miru
    autorandr
    arandr
  ];

  services = {
    batteryNotifier = {
      enable = true;
      device = "BAT1";
      notifyCapacity = 100;
    };
  };

  xsession.windowManager.i3.config = {
    keybindings = lib.mkOptionDefault {
      "Ctrl+${modifier}+Up" = "move workspace to output ${secondary}";
      "Ctrl+${modifier}+Down" = "move workspace to output ${primary}";
    };
  };
}
