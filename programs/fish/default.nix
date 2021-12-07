{ my, ... }:

let
  dir = "${my.config.nixpkgs}/programs/fish";
in
{
  enable = true;

  shellInit = " \
    source ${dir}/aliases.sh
    source ${dir}/${my.config.colorscheme_name}.fish
    set fish_greeting
    set EDITOR /usr/bin/env nvim
  ";
}
