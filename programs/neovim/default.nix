{ config, lib, pkgs, ... }:

let
  my = import ../../config;

  vim_folder = "${my.config.nixpkgs}/programs/neovim";
  vim_plugins = "${my.config.nixpkgs}/programs/neovim/plugins";
  vim_lua = "${my.config.nixpkgs}/programs/neovim/lua";
  vim_themes = "${my.config.nixpkgs}/programs/neovim/themes";

  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };

    # always installs latest version
  plugin = pluginGit "HEAD";

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
        source ${vim_plugins}/plugins.vim
        source ${vim_themes}/tokyonight.vim
        lua dofile("${vim_lua}/plugins.lua")
        '';

        plugins = with pkgs.vimPlugins; [ 
            # Packages
            packer-nvim

            # Navigation
            nvim-web-devicons
            fzf-vim
            rnvimr
            (plugin "folke/which-key.nvim")

            # Eyecandy
            nvim-treesitter
            vim-css-color    # Color previewer
            indentLine

            # CMP
            (plugin "neovim/nvim-lspconfig")
            (plugin "hrsh7th/nvim-cmp")
            (plugin "hrsh7th/cmp-nvim-lsp")
            (plugin "hrsh7th/cmp-cmdline")
            (plugin "hrsh7th/nvim-compe")
            (plugin "hrsh7th/cmp-buffer")
            (plugin "hrsh7th/cmp-path")
            (plugin "hrsh7th/cmp-emoji")
            (plugin "ojroques/nvim-lspfuzzy")

            # Snippets
            (plugin "L3MON4D3/LuaSnip")
            (plugin "saadparwaiz1/cmp_luasnip")
            (plugin "tami5/lspsaga.nvim")
            (plugin "mortepau/codicons.nvim")
            (plugin "onsails/lspkind-nvim")

        ] ++ ( with pkgs.nur.repos.m15a.vimExtraPlugins; [
            tokyodark-nvim # FIXME: https://github.com/tiagovla/tokyodark.nvim/issues/14#issue-1144674199
            # feline-nvim
        ]);
    };
}
