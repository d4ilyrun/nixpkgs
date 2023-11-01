{ config, ... }:

{
  programs.rofi.theme = "${config.dotfiles.theme.directory}/catppuccin.rasi";
}
