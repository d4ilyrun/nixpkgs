{ config, pkgs, ... }:

{
  xdg.configFile."ranger".source = "${config.dotfiles.folders.applications}/ranger";
}
