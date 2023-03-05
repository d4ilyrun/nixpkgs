{ config, ... }:

let
  name = "catppuccin";
  flavour = "mocha";
in
{
  imports = [ ];

  programs.kitty.extraConfig =
    builtins.readFile (
      builtins.fetchurl
        "https://raw.githubusercontent.com/catppuccin/kitty/main/themes/${flavour}.conf"
    );

  dotfiles.extraOptions = {
    theme = {
      inherit flavour;
    };
  };

  dotfiles.theme = {
    inherit name;
    colors = rec {
      primary = {
        background = "#1E1D2F";
        foreground = "#D9E0EE";
        accent = normal.magenta;
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
