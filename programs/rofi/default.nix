{ my, ... }:

let
  config = "carbonized";
  path = "${my.config.nixpkgs}/programs/rofi";
in
  {
    enable = true;

    configPath = "${path}/${config}.rasi";

    extraConfig = with my.config.colorscheme; {
      bg = primary.background;
      fg = primary.background;
      button = "#9e9e95";
      background-color = primary.background;
      text-color = primary.foreground;
    };
}
