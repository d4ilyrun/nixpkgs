local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

local active_lsp = vim.lsp.get_active_clients()
active_lsp = active_lsp ~= nil and active_lsp[1] or "None"

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
        lualine_c = { { lsp_info } },
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

