rec {
  colorschemes = import ./colorschemes.nix;

  config = {
    home = "home/leo";
    username = "leo";
    nixpkgs = "home/leo/.config/nixpkgs";

    colorscheme_name = "tokyonight";
    colorscheme = colorschemes.tokyonight;
  };
}
