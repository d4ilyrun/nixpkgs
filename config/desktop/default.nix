#~/.config/nixpkgs/config/desktop/index.nix
{ my, config, lib, pkgs, spicetify-nix, ... }:

let
  nixpkgs = my.config.nixpkgs;
  programs = "${nixpkgs}/applications";

  modifier = "Mod4";
  primary = "DisplayPort-0";
  secondary = "HDMI-A-0";

  gaps = {
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

    (import "${programs}/spicetify" { inherit my pkgs spicetify-nix; })
    (import "${programs}/polybar" { inherit my pkgs lib; network = "wlp35s0"; })
    (import "${programs}/i3" { inherit my pkgs lib gaps; })
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
