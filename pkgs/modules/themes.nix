# This file defines a module defining a theme colorscheme

{ config, pkgs, lib, ... }:

with lib;

let
  colorType = types.strMatching "#[0-9A-Fa-f]{6}";

  mkColorOption = name: mkOption {
    description = "The ${name} color";
    type = colorType;
    example = "#123abC";
  };

  /* Generate a set containing a color option for each color in the list. */
  colorPalette = attrsets.genAttrs
    [ "black" "red" "green" "yellow" "blue" "magenta" "cyan" "white" ]
    mkColorOption
  ;
in
{
  options.dotfiles.theme = mkOption {
    description = ''
      The global theme of the config.
      Can either be a string (the name of the theme), or an attribute set.
      If given a string 'name' the colorscheme will be retrieved from <themes/name/default.nix>.
    '';
    type = types.either types.str
      (types.submodule {
        options = {

          name = mkOption {
            type = types.str;
            description = "The theme's name";
            example = "catpuccin";
          };

          directory = mkOption {
            type = types.str;
            description = ''
              The path to the theme's config directory.
              It should contain all the necessary configurations to apply the theme.
              It has to contain `default.nix` file, used as an entry point.
            '';
          };

          colors = {
            primary = {
              background = mkColorOption "background";
              foreground = mkColorOption "background";
              accent = mkColorOption "background";
            };

            normal = colorPalette;
            bright = colorPalette;
          };
        };
      })
    ;
  };
}
