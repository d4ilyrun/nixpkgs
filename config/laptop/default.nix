# laptop-specific configuration
# Lenovo T14

{ lib, ... }:

let
  modifier = "Mod4";
  primary = "eDP-1";
  secondary = "HDMI-1";
  battery = "BAT0";

in
{
  dotfiles = {
    extraOptions = {
      network = "wlp2s0";
      battery = {
        inherit battery;
        adapter = "ACAD";
      };
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
      ./autorandr.nix
    ];
  };

  services = {
    lowbatt = {
      enable = true;
      device = battery;
      notifyCapacity = 15;
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

  programs.kitty.settings.font_size = "20.0";
  services.polybar.settings = {
    "module/filesystem" = {
      mount-1 = lib.mkForce "/home";
      mount-2 = lib.mkForce "/nix";
    };
  };
}
