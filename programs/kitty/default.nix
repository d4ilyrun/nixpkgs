{ pkgs, lib, ... }:

let

  fetchCatppuccin = flavour: builtins.fetchurl "https://raw.githubusercontent.com/catppuccin/kitty/main/${flavour}.conf";

in

{
  programs.kitty = {
    enable = true;

    settings = {

      shell = "${pkgs.fish}/bin/fish";

      # FONT
      font_size = "13.0";
      font_family = "FiraCode Nerd Font";
      bold_font = "auto";
      italic_font = "Fira Sans Italic"; # Cause fira code does not include italics
      bold_italic_font = "Fira Sans Bold Italic";

      # TODO: Nvim not transparent
      background_opacity = "1";
    };

    environment = {
      "TERM" = "xterm-256color";
    };

    # TODO: Theme directory -> import depending on the theme
    extraConfig = builtins.readFile (fetchCatppuccin "mocha");
  };

  home.sessionVariables."TERMINAL" = "kitty";
}
