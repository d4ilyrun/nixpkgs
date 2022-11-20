require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "catppuccin",
        disabled_filetypes = {},
        component_separators = "|",
        section_separators = { left = ' ', right = ' ' },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { { "branch" }, { "diff", source = diff_source } },
        lualine_c = { },
        lualine_x = {
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = {
                    debug = " ",
                    error = " ",
                    info = " ",
                    trace = "✎ ",
                    warn = " "
                },
            },
        },
        lualine_y = {
            { "filetype", colored = true, icon_only = true, icon = { "❄ ❅ ❆" } },
            { "encoding" },
            {
                "fileformat",
                icons_enabled = true,
                symbols = {
                    unix = "",
                    dos = "",
                    mac = "",
                },
            },
        },
        lualine_z = { "progress", "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {
        "quickfix",
        "nvim-tree",
        "nvim-dap-ui",
        "toggleterm",
        "fugitive",
    },
})
