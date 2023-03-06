#~/.config/nixpkgs/config/desktop/index.nix
{ my, config, lib, pkgs, spicetify-nix, ... }:

let
  nixpkgs = my.config.nixpkgs;
  programs = "${nixpkgs}/applications";

  modifier = "Mod4";
  primary = "eDP-1-1";
  secondary = "HDMI-0";

  gaps = {
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

    (import "${programs}/spicetify" { inherit my pkgs spicetify-nix; })
    (import "${programs}/polybar" { inherit my pkgs lib; network = "wlp0s20f3"; })
    (import "${programs}/i3" { inherit my pkgs lib gaps; })
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
    lowbatt = {
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
