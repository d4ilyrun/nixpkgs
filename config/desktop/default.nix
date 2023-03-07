#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, ... }:

let
  modifier = "Mod4";
  primary = "DisplayPort-0";
  secondary = "HDMI-A-0";
in
{
  dotfiles = {
    extraOptions = {
      network = "wlp35s0";
      monitor = {
        inherit primary secondary;
      };
    };
  };

  imports = lib.importConfig {
    pkgs = [ "system" "dev" "apps" "school" "fonts" ];
    applications = [ "polybar" "i3" "spicetify" ];
    imports = [
      ../minimal
    ];
  };

  home.packages = with pkgs; [
    autorandr
  ];

  programs = {
    autorandr = import "${applications}/autorandr/desktop.nix";
    alacritty.settings.font.size = lib.mkForce 12.0;
  };

  xsession.windowManager.i3.config = {
    keybindings = lib.mkOptionDefault {
      "Ctrl+${modifier}+Left" = "move workspace to output ${secondary}";
      "Ctrl+${modifier}+Right" = "move workspace to output ${primary}";
    };
    gaps = {
      inner = 12;
      smartGaps = false;
    };
  };
}
