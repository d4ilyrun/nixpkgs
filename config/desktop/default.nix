#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, ... }:

let
  my = import ../.;
  programs = "${my.config.nixpkgs}/programs";
  modifier = "Mod4";
  primary = "DisplayPort-0";
  secondary = "HDMI-A-0";
in
{
    imports = [
        ../laptop
    ];

    home.packages = with pkgs; [ autorandr ];

    programs = {
        autorandr = import "${programs}/autorandr/desktop.nix";
    };

    # Changes from the default configuration (laptop)

    xsession.windowManager.i3.config = {
        keybindings = lib.mkOptionDefault {
            "Ctrl+${modifier}+Right" =  "move workspace to output ${secondary}";
            "Ctrl+${modifier}+Left" = "move workspace to output ${primary}";
        };
    };
    
    programs.alacritty.settings.font.size = lib.mkForce 11.0;
}
