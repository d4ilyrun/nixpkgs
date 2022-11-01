syntax on

lua << EOF

local onedark = require('onedark')

local colors = {
    black = "#000000",
    bg_d = '#0a0d11',
    bg0 = '#101317',
    bg1 = '#13161a',
    bg2 = "#171b20",
    bg3 = "#1b1f25",
    ColorColumn = "#43262a",
    Whitespace = "#262a30",
    IndentBlanklineSpaceChar = "#262a30",
    FloatBorder = "#101317",
    NvimTreeIndentMarker = "#262a30",
}

local ts_colors = {
    white = "#ffffff",
    yellow = "#cfcf60",
    red = "#af3030",
    green = "#303fa0",
    darker_black = "#070a0e",
    black = '#0a0d11',
    black2 = "#171b20",
}

-- Lua
onedark.setup  {
    -- Main options --
    style = 'deep', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'bold',
        functions = 'italic',
        strings = 'none',
        variables = 'none'
    },

    -- Lualine options --
    lualine = {
        transparent = false, -- lualine center bar transparency
    },


    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },

    -- Custom Highlights --
    colors = colors, -- Override default colors
    highlights = {
        ColorColumn = { bg = colors.ColorColumn },
        Whitespace = { fg = colors.Whitespace },
        IndentBlanklineSpaceChar = { fg = colors.IndentBlanklineSpaceChar },
        FloatBorder = { bg = colors.FloatBorder },
        NvimTreeIndentMarker = { fg = colors.NvimTreeIndentMarker },

        TelescopeBorder = { fg = ts_colors.darker_black, bg = ts_colors.darker_black, },
        TelescopeNormal = { bg = ts_colors.darker_black },
        TelescopeSelection = { bg = ts_colors.black2, fg = ts_colors.white },
        TelescopePromptTitle = { fg = ts_colors.white, bg = ts_colors.red, },
        TelescopePromptBorder = { fg = ts_colors.black2, bg = ts_colors.black2, },
        TelescopePromptNormal = { fg = ts_colors.white, bg = ts_colors.black2, },
        TelescopePromptPrefix = { fg = ts_colors.red, bg = ts_colors.black2, },
        TelescopePreviewTitle = { fg = ts_colors.white, bg = ts_colors.green, },
        TelescopePreviewBorder = { fg = ts_colors.darker_black, bg = ts_colors.darker_black, },
        TelescopeResultsTitle = { fg = ts_colors.black, bg = ts_colors.black, },
        TelescopeResultsNormal = { bg = ts_colors.black, },
        TelescopeResultsBorder = { fg = ts_colors.black, bg = ts_colors.black, },
        TelescopeResultsDiffAdd = { fg = ts_colors.green, },
        TelescopeResultsDiffChange = { fg = ts_colors.yellow, },
        TelescopeResultsDiffDelete = { fg = ts_colors.red, },
    }
}

onedark.load()

EOF
