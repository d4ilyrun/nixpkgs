let
  dir = "~/.config/nixpkgs/programs/fish";
  themes = "tokyonight";
in
{
  enable = true;

  shellInit = " \
    set theme_color_scheme nord \
    source ${dir}/aliases.sh
    source ${dir}/${themes}.fish
  ";
}
