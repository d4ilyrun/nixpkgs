{ my, lib, pkgs, ... }:

let
  functions = import ./themes.nix { inherit lib; };
  target = ".config/awesome";
in
with my.config; {

  inherit (functions);

  #  home.file = {
  #    "awesome_theme_${colorscheme_name}" = {
  #      target = "${target}/theme/${colorscheme_name}";
  #      text = (functions.writeColorTheme colorscheme_name colorscheme);
  #    };
  #
  #    awesome_rc = {
  #      target = "${target}/rc.lua";
  #      source = ./rc.lua;
  #    };
  #
  #    awesome_config = {
  #      target = "${target}/config";
  #      source = ./config;
  #    };
  #  };

  home.packages = with pkgs.luaPackages; [
    luarocks
  ];

  xdg.configFile."awesome".source = ./.;
}
