{ pkgs, my, ... }:

{
  enable = true;
  terminal = "xterm-256color";
  shell = "${pkgs.fish}/bin/fish";
  clock24 = true;
  prefix = "C-x";

  extraConfig = with my.config.colorscheme; ''
  set -g status-bg magenta
  set -g status-fg black
  set -g mouse on
  '';
}
