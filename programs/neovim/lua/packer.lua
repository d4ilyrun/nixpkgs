vim.api.nvim_command('packadd packer.nvim')

return require('packer').startup(function()
    -- Themes
    use 'folke/tokyonight.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'

    -- Autocompletion
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp'

    -- Snippets
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'onsails/lspkind-nvim'

    -- JSP
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        -- tag = 'release' -- To use the latest release
    }

    use {
        "NTBBloodbath/galaxyline.nvim",
        -- some optional icons
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }

end)

