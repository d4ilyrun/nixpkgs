{ pkgs, my, ... }:

{
  enable = true;
  terminal = "xterm-256color";
  shell = "${pkgs.fish}/bin/fish";
  clock24 = true;
  prefix = "C-x";

  extraConfig = builtins.readFile "${my.config.nixpkgs}/programs/tmux/tokyodark.conf";
}
