{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;

    settings = {

      shell = "${pkgs.fish}/bin/fish";

      # FONT
      font_size = lib.mkOverridable "13.0";
      font_family = "Fira Code Nerd Font";
      bold_font = "auto";
      italic_font = "Fira Sans Italic"; # Cause fira code does not include italics
      bold_italic_font = "Fira Sans Bold Italic";

      # TODO: Nvim not transparent
      background_opacity = "1";
    };

    environment = {
      "TERM" = "kitty";
    };
  };
}
