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

  pluginWithName = name: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = name;
    version = "HEAD";
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = "HEAD";
    };
  };

in
{
  # Packages needed for neovim to work
  home.packages = with pkgs; [
    rnix-lsp
    nodePackages.pyright
    nodePackages.typescript-language-server
    sumneko-lua-language-server
    glow
    ripgrep
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;

    extraConfig = ''
      lua home = "${my.config.home}"
      lua path = "${vim_lua}"
      let g:vim_plugins_path="${vim_plugins}"

      source ${vim_folder}/settings.vim
      source ${vim_plugins}/plugins.vim
      source ${vim_themes}/${my.config.colorscheme_name}.vim
      lua dofile("${vim_lua}/init.lua")
    '';

    plugins = with pkgs.vimPlugins; [
      # Navigation
      (plugin "max397574/which-key.nvim")
      (plugin "airblade/vim-rooter")
      (plugin "startup-nvim/startup.nvim")
      (plugin "nvim-telescope/telescope.nvim")
      (plugin "kyazdani42/nvim-tree.lua")
      (plugin "akinsho/bufferline.nvim")
      (plugin "moll/vim-bbye")
      (plugin "folke/trouble.nvim")
      (plugin "folke/todo-comments.nvim")
      (plugin "BurntSushi/ripgrep")

      # Eyecandy
      nvim-treesitter
      nvim-web-devicons
      (plugin "glepnir/galaxyline.nvim")
      (plugin "norcalli/nvim-colorizer.lua") # color-previewer
      (plugin "lukas-reineke/indent-blankline.nvim")
      (plugin "smithbm2316/centerpad.nvim")

      # LSP
      (plugin "neovim/nvim-lspconfig")
      (plugin "williamboman/nvim-lsp-installer")
      (plugin "ojroques/nvim-lspfuzzy")

      # CMP
      (plugin "hrsh7th/nvim-cmp")
      (plugin "hrsh7th/cmp-nvim-lsp")
      (plugin "hrsh7th/cmp-cmdline")
      (plugin "hrsh7th/cmp-buffer")
      (plugin "hrsh7th/cmp-path")
      (plugin "hrsh7th/cmp-nvim-lsp-signature-help")

      # Snippets
      (plugin "L3MON4D3/LuaSnip")
      (plugin "saadparwaiz1/cmp_luasnip")
      (plugin "tami5/lspsaga.nvim")
      (plugin "mortepau/codicons.nvim")
      (plugin "onsails/lspkind-nvim")

      # Dev
      (plugin "nvim-lua/plenary.nvim")
      (plugin "jose-elias-alvarez/null-ls.nvim")
      (plugin "mfussenegger/nvim-dap")
      (plugin "rcarriga/nvim-dap-ui")
      (plugin "nvim-telescope/telescope-dap.nvim")
      (plugin "Shatur/neovim-cmake")
      (plugin "danymat/neogen")
      (plugin "lewis6991/gitsigns.nvim")

      # Media files
      (plugin "marioortizmanero/adoc-pdf-live.nvim") # PDF viewer
      glow-nvim

      # themes
      (pluginWithName "catpuccin" "catppuccin/nvim")
      (plugin "joshdick/onedark.vim")
      (plugin "tiagovla/tokyodark.nvim")
    ];
  };
}
