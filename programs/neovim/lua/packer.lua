return require('packer').startup(function()
    -- Themes
    use 'folke/tokyonight.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'

    -- Autocompletion
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'
    -- use 'hrsh7th/cmp-nvim-path'
    -- use 'hrsh7th/cmp-nvim-buffer'
    -- use 'hrsh7th/cmp-luasnip'

    -- Snippets
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'onsails/lspkind-nvim'
end)

