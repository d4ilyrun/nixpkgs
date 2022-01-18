rec {
  colorschemes = import ./colorschemes.nix;

  config = rec {
    username = "leo";
    home = "/home/${config.username}";
    nixpkgs = "${config.home}/.config/nixpkgs";

    colorscheme_name = "tokyonight";
    colorscheme = colorschemes.tokyonight;
  };
}
