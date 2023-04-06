{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;

    extraPackages = with pkgs; [
      ripgrep # for telescope/fzf
    ];
  };

  # LSP
  home.packages = with pkgs; [
    nil
    sumneko-lua-language-server
    nodePackages.pyright
  ];
}
