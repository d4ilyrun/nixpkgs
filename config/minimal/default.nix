{ lib, nixpkgs, ... }:

{
  home.sessionVariables = {
    NIX_PATH = builtins.concatStringsSep ":" [
      "nixos=${nixpkgs.outPath}"
      "nixpkgs=${nixpkgs.outPath}"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
  };

  imports = lib.importConfig {
    services = [ "dunst" "picom" ];
    applications = [ "alacritty" "firefox" "fish" "kitty" "neovim" "rofi" "tmux" "zathura" ];
  };
}
