{ pkgs, ...}:

let
  config = "carbonized";
  colorschemes = import ~/.config/nixpkgs/config/colorschemes.nix;
  path = "~/.config/nixpkgs/programs/rofi";
in
  {
    enable = true;

    configPath = "${path}/${config}.rasi";

    extraConfig = with colorschemes.tokyonight; {
      bg = primary.background;
      fg = primary.background;
      button = "#9e9e95";
      background-color = "@bg";
      text-color = "@fg";
    };
}
