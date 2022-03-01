{ config, lib, pkgs, ... }:

let
  my = import ../../config;

  vim_folder = "${my.config.nixpkgs}/programs/neovim";
  vim_plugins = "${my.config.nixpkgs}/programs/neovim/plugins";
  vim_lua = "${my.config.nixpkgs}/programs/neovim/lua";
  vim_themes = "${my.config.nixpkgs}/programs/neovim/themes";
in
    {
    # Packages needed for neovim to work
    home.packages = with pkgs; [
        rnix-lsp
        python39Packages.pynvim # TODO: lern how to add pytohn packages on a user level
    ];

    programs.neovim = {
        enable = true;
        vimAlias = true;
        viAlias = true;

        extraConfig = ''
        lua path = "${vim_lua}"
        let g:vim_plugins_path="${vim_plugins}"

        source ${vim_folder}/settings.vim
        source ${vim_themes}/tokyonight.vim
        source ${vim_plugins}/plugins.vim
        lua dofile("${vim_lua}/plugins.lua")
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
