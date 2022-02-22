{ config, lib, pkgs, ... }:

let
  my = import ../../config;

  vim_folder = "${my.config.nixpkgs}/programs/neovim";
  vim_plugins = "${my.config.nixpkgs}/programs/neovim/plugins";
  vim_lua = "${my.config.nixpkgs}/programs/neovim/lua";
  vim_themes = "${my.config.nixpkgs}/programs/neovim/themes";

  tokyo-night = pkgs.fetchFromGitHub {
    owner = "folke";
    repo = "tokyonight.nvim";
    rev = "2981e4bd0919305675d8d665f9a20281bb33ed06";
    sha256 = "15kv5g1srqsayryf3x469sl2bgaq69ni31imp7yi7dfvmzlxf6q1";
  };

in
    {
    # Packages needed for neovim to work
    home.packages = with pkgs; [
        rnix-lsp
        python39Packages.pynvim
    ];

    programs.neovim = {
        enable = true;
        vimAlias = true;
        viAlias = true;

        extraConfig = ''
            source ${vim_folder}/settings.vim
            lua dofile("${vim_lua}/packer.lua")
            source ${vim_themes}/tokyonight.vim
            " lua dofile("${vim_lua}/feline.lua")
            lua dofile("${vim_lua}/galaxyline.lua")
            lua dofile("${vim_lua}/lsp.lua")
            source ${vim_plugins}/lsp.vim
        '';

        plugins = with pkgs.vimPlugins; [ 
            # Packages
            packer-nvim

            # StatusBar
            #lualine-nvim

            # Navigation
            nvim-web-devicons
            fzf-vim
            rnvimr

            # LSP
            nvim-treesitter
            vim-polyglot
            nvim-cmp
            cmp-buffer
            cmp-path

            # Eyecandy
            vim-css-color    # Color previewer
            indentLine

        ] ++ ( with pkgs.nur.repos.m15a.vimExtraPlugins; [
            tokyodark-nvim # FIXME: https://github.com/tiagovla/tokyodark.nvim/issues/14#issue-1144674199
            # feline-nvim
        ]);
    };
}
