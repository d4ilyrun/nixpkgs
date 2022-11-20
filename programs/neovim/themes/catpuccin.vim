lua << EOF

require("catppuccin").setup({
    flavour = "mocha", -- Can be one of: latte, frappe, macchiato, mocha
    background = { light = "latte", dark = "mocha" },
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.5,
    },
    transparent_background = false,
    term_colors = true,
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    styles = {
        comments = { "italic" },
        properties = { "italic" },
        functions = { "italic" },
        keywords = { "italic" },
        operators = { "bold" },
        conditionals = { "bold" },
        loops = { "bold" },
        booleans = { "bold", "italic" },
        numbers = {},
        types = {},
        strings = {},
        variables = {},
    },
    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
        lsp_trouble = true,
        lsp_saga = true,
        fidget = true,
        gitgutter = false,
        gitsigns = true,
        telescope = true,
        nvimtree = true,
        which_key = true,
        indent_blankline = { enabled = true, colored_indent_levels = false },
        markdown = true,
        neotest = false,
        noice = true,
        cmp = true,
        dap = { enabled = true, enable_ui = true },
        notify = true,
        symbols_outline = false,
    },
    highlight_overrides = {
        mocha = function(cp)
            return {
                -- For base configs.
                CursorLineNr = { fg = cp.green },
                Search = { bg = cp.surface1, fg = cp.pink, style = { "bold" } },
                IncSearch = { bg = cp.pink, fg = cp.surface1 },
                NormalFloat = { bg = cp.mantle },

                -- For Telescope
                TelescopeBorder = { fg = cp.blue },
                TelescopeSelectionCaret = { fg = cp.flamingo },
                TelescopeSelection = { fg = cp.rosewater, bg = cp.surface0, style = { "bold" } },
                TelescopeMatching = { fg = cp.blue },
                TelescopePromptPrefix = { fg = cp.rosewater, bg = cp.crust },
                TelescopePromptNormal = { bg = cp.crust},
                TelescopeResultsNormal = { bg = cp.mantle},
                TelescopePreviewNormal = { bg = cp.crust },
                TelescopePromptBorder = { bg = cp.crust, fg = cp.crust },
                TelescopeResultsBorder = { bg = cp.mantle, fg = cp.crust },
                TelescopePreviewBorder = { bg = cp.crust, fg = cp.crust },
                TelescopePromptTitle = { fg = cp.crust },

                -- For native lsp configs.
                DiagnosticVirtualTextError = { bg = cp.none },
                DiagnosticVirtualTextWarn = { bg = cp.none },
                DiagnosticVirtualTextInfo = { bg = cp.none },
                DiagnosticVirtualTextHint = { fg = cp.rosewater, bg = cp.none },

                DiagnosticHint = { fg = cp.rosewater },
                LspDiagnosticsDefaultHint = { fg = cp.rosewater },
                LspDiagnosticsHint = { fg = cp.rosewater },
                LspDiagnosticsVirtualTextHint = { fg = cp.rosewater },
                LspDiagnosticsUnderlineHint = { sp = cp.rosewater },

                -- For treesitter.
                ["@field"] = { fg = cp.rosewater },
                ["@property"] = { fg = cp.yellow },

                ["@text.uri"] = { fg = cp.rosewater, style = { "italic", "underline" } },

                ["@function.builtin.bash"] = { fg = cp.red, style = { "italic" } },
                ["@parameter.bash"] = { fg = cp.yellow, style = { "italic" } },

                ["@field.lua"] = { fg = cp.teal },
                ["@constructor.lua"] = { fg = cp.flamingo },

                ["@type.css"] = { fg = cp.lavender },
                ["@property.css"] = { fg = cp.yellow, style = { "italic" } },

                ["@include.cpp"] = { fg = cp.maroon },
                ["@property.cpp"] = { fg = cp.text },
            }
        end,
    },
})

vim.cmd.colorscheme "catppuccin"

EOF
