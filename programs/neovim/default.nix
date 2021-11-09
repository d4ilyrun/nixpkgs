{ pkgs, ... }:
let
  vim_folder = ~/.config/nixpkgs/programs/neovim;
  vim_plugins = ~/.config/nixpkgs/programs/neovim/plugins;
  vim_lua = ~/.config/nixpkgs/programs/neovim/lua;
  vim_themes = ~/.config/nixpkgs/programs/neovim/themes;

  tokyo-night = pkgs.fetchFromGitHub {
    owner = "folke";
    repo = "tokyonight.nvim";
    rev = "2981e4bd0919305675d8d665f9a20281bb33ed06";
    sha256 = "15kv5g1srqsayryf3x469sl2bgaq69ni31imp7yi7dfvmzlxf6q1";
  };

in
{
  enable = true;
  vimAlias = true;
  viAlias = true;

  extraConfig = ''
    source ${vim_folder}/settings.vim
    lua dofile("${vim_lua}/packer.lua")
    source ${vim_themes}/tokyonight.vim
    source ${vim_plugins}/lsp.vim
  '';

  plugins = with pkgs.vimPlugins; [ 
    packer-nvim

    # StatusBar
    # vim-airline
    lualine-nvim

    # Navigation
    nvim-web-devicons
    nerdtree
    fzf-vim

    # LSP
    vim-polyglot

    # Completion
    nvim-treesitter

    # Eyecandy
    vim-css-color    # Color previewer
    indentLine
    # nord-vim
  ];
}
