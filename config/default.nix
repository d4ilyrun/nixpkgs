rec {

  colorschemes = import ./colorschemes.nix;
  wallpapers = import "${config.nixpkgs}/config/wallpapers.nix";

  config = rec {
    username = "lduboin";
    machine = "desktop";
    home = "/home/${config.username}";
    nixpkgs = "${config.home}/.config/nixpkgs";

    colorscheme_name = "catpuccin";
    colorscheme = colorschemes.catpuccin;

    wallpaper = wallpapers.anime.sangatsu;
  };
}
