#~/.config/nixpkgs/config/desktop/index.nix
{ config, lib, pkgs, ... }:

let
  # Cannot use config.dotfiles here or it will cause an inifinite reccursion
  applications = ../../applications;
  packages = ../../pkgs;
  services = ../../services;

in
{
  imports = lib.importConfig {
    services = [ "dunst" "picom" ];
    applications = [ "alacritty" "firefox" "fish" "kitty" "neovim" "rofi" "tmux" ];
  };
}
