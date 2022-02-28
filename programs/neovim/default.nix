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

    home.sessionVariables = rec {
        EDITOR = "${pkgs.neovim}/bin/neovim";
    };

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
