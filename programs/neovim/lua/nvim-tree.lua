require'nvim-tree'.setup {
    view = {
        width = 20,
        height = 20,
    },

    create_in_closed_folder = true,

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
