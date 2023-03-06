-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require'nvim-tree'.setup {
    sync_root_with_cwd = true,

    update_focused_file = {
        enable = true,
        update_cwd = false,
    },

    view = {
        adaptive_size = false,
        centralize_selection = false,
        width = 30,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        hide_root_folder = false,
        float = {
            enable = false,
            open_win_config = {
                relative = "editor",
                border = "rounded",
                width = 30,
                height = 30,
                row = 1,
                col = 1,
            },
        },
    },

    renderer = {
        highlight_opened_files = "icon",
        group_empty = true,
        indent_markers = { enable = true },

        special_files = { "README.md", "Makefile", "MAKEFILE" },

        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true
            },
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    deleted = "",
                    ignored = "◌",
                    untracked = "?",
                },
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                },
            },
        },
    },

    actions = {
        open_file = {
            quit_on_open = true
        },
    },
}
