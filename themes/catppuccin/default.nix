{ config, lib, ... }:

let
  name = "catppuccin";
  flavour = "mocha";
  accent = "rosewater";
in
{
  imports = [
    ./firefox.nix
    ./rofi.nix
    ./wallpapers.nix
    ./dunst.nix
  ];

  dotfiles.extraOptions = {
    theme = {
      inherit flavour accent;
    };
  };

  programs = {
    kitty.extraConfig =
      builtins.readFile (
        builtins.fetchurl
          "https://raw.githubusercontent.com/catppuccin/kitty/main/themes/${flavour}.conf"
      );
  };

  dotfiles.theme = {
    inherit name;
    directory = "${config.dotfiles.repository}/themes/catppuccin";
    colors = rec {
      primary = {
        background = "#1E1D2F";
        foreground = "#D9E0EE";
        accent = "#B4BEFE";
      };

      normal = {
        black = "#6E6C7E";
        red = "#F28FAD";
        green = "#ABE9B3";
        yellow = "#FAE3B0";
        blue = "#96CDFB";
        magenta = "#F5C2E7";
        cyan = "#89DCEB";
        white = "#D9E0EE";
      };

      bright = {
        black = "#988BA2";
        red = "#F28FAD";
        green = "#ABE9B3";
        yellow = "#FAE3B0";
        blue = "#96CDFB";
        magenta = "#F5C2E7";
        cyan = "#89DCEB";
        white = "#D9E0EE";
      };
    };
  };
}
