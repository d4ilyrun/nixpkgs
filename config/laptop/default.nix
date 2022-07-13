#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, ... }:

let
  my = import ../.;
  programs = "${my.config.nixpkgs}/programs";

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
    "${nixpkgs}/pkgs/acdc.nix"

    # Fonts
    "${nixpkgs}/pkgs/fonts.nix"

    # Minimal configuration
    ../minimal

    # TODO: change it to an import function
    "${programs}/battery.nix"

    (import "${programs}/spicetify" { inherit my pkgs; })
    #(import "${programs}/awesome" { inherit my lib pkgs; })
    (import "${programs}/polybar" { inherit my pkgs lib; network = "wlp0s20f3"; })
    (import "${programs}/i3/i3.nix" { inherit my pkgs lib my_gaps; })
  ];

  # Standalone programs (don't need to download other configurations or change system-wide configurations)
  programs = { };

  home.packages = [
    jetbrains.clion
  ];

  services = {
    batteryNotifier = {
      enable = true;
      device = "BAT1";
    };
  };
}
