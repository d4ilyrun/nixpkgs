let
  dir = "~/.config/nixpkgs/programs/fish";
  themes = "tokyonight";
in
{
  enable = true;

  shellInit = " \
    source ${dir}/aliases.sh
    source ${dir}/${themes}.fish
    set fish_greeting
  ";
}
