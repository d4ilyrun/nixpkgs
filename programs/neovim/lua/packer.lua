vim.api.nvim_command('packadd packer.nvim')

return require('packer').startup(function()
    -- Themes
    use 'folke/tokyonight.nvim'
    use 'justinmk/vim-syntax-extra'

    -- Snippets
    use 'onsails/lspkind-nvim'

    -- Git
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

