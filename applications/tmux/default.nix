{ pkgs, my, ... }:

{
  enable = true;

  prefix = "C-x";
  keyMode = "vi";

  terminal = "tmux-256color";
  shell = "${pkgs.fish}/bin/fish";

  clock24 = true;
  baseIndex = 1;
  sensibleOnTop = true;

  extraConfig = builtins.readFile "${my.config.nixpkgs}/applications/tmux/tokyodark.conf";
}
