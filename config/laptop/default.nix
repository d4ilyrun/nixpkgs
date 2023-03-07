#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, spicetify-nix, ... }:

let
  inherit (config.dotfiles.folders) applications;

  modifier = "Mod4";
  primary = "eDP-1-1";
  secondary = "HDMI-0";

in
{
  dotfiles = {
    extraOptions = {
      network = "wlp0s20f3";
      monitor = {
        inherit primary secondary;
      };
    };
  };

  imports = lib.importConfig {
    pkgs = [ "system" "dev" "apps" "school" "fonts" ];
    applications = [ "spicetify" "i3" "polybar" ];
    imports = [
      ../minimal
    ];
  };

  # Standalone programs (don't need to download other configurations or change system-wide configurations)
  programs = {
    autorandr = import "${applications}/autorandr/laptop.nix";
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
    gaps = {
      inner = 8;
      smartGaps = false;
    };
  };
}
