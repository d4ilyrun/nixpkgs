#~/.config/nixpkgs/config/desktop/index.nix
{ my, config, lib, pkgs, ... }:

let
  programs = "${my.config.nixpkgs}/programs";
in
{
  imports = [
    "${programs}/neovim"
    "${programs}/fish"
    "${programs}/rofi"

    (import "${programs}/picom" { inherit pkgs; })
  ];

  # Standalone programs (don't need to download other configurations or change system-wide configurations)
  programs = {
    alacritty = import "${programs}/alacritty/default-settings.nix" { inherit my pkgs; };
    firefox = import "${programs}/firefox" { inherit my pkgs lib; };
    tmux = import "${programs}/tmux" { inherit pkgs my; };
  };

  services = {
    dunst = import "${programs}/dunst" { inherit my pkgs; };
  };
}
