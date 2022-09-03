#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, ... }:

let
  my = import ../.;
  nixpkgs = my.config.nixpkgs;
  programs = "${nixpkgs}/programs";

  modifier = "Mod4";
  primary = "DisplayPort-0";
  secondary = "HDMI-A-0";

  my_gaps = {
    inner = 8;
    smartGaps = false;
  };
in
{
  imports = with pkgs; [
    # Packages
    "${nixpkgs}/pkgs/system.nix"
    "${nixpkgs}/pkgs/dev.nix"
    "${nixpkgs}/pkgs/apps.nix"
    "${nixpkgs}/pkgs/school.nix"

    # Fonts
    "${nixpkgs}/pkgs/fonts.nix"

    # Minimal configuration
    ../minimal

    (import "${programs}/spicetify" { inherit my pkgs; })
    (import "${programs}/polybar" { inherit my pkgs lib; network = "wlp35s0"; })
    (import "${programs}/i3/i3.nix" { inherit my pkgs lib my_gaps; })
  ];

  home.packages = with pkgs; [
    autorandr
  ];

  programs = {
    autorandr = import "${programs}/autorandr/desktop.nix";
  };

  # Changes from the default configuration (laptop)

  xsession.windowManager.i3.config = {
    keybindings = lib.mkOptionDefault {
      "Ctrl+${modifier}+Left" = "move workspace to output ${secondary}";
      "Ctrl+${modifier}+Right" = "move workspace to output ${primary}";
    };
  };

  programs.alacritty.settings.font.size = lib.mkForce 12.0;
}
