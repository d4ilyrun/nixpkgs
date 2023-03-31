local mocha = require('catppuccin.palettes').get_palette "mocha"

diagnostics_indicator = function(count, level, diagnostics_dict, context)
  local s = " "
  for e, n in pairs(diagnostics_dict) do
    local sym = e == "error" and " "
      or (e == "warning" and " " or "" )
      if sym ~= "" then
          s = n .. sym .. s
      end
  end
  return s
end

vim.opt.termguicolors = true

local opts = {
    options = {
        number = nil,
        close_command = "Bdelete! %d",
        right_mouse_command = "Bdelete! %d",
        left_mouse_command = "buffer %d",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        show_buffer_close_icons = true,
        show_buffer_icons = true,
        show_tab_indicators = true,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        separator_style = "thin",

        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                padding = 1,
            },
            {
                filetype = "undotree",
                text = "Undo Tree",
                text_align = "center",
                highlight = "Directory",
                separator = true,
            },
        },

        diagnostics_indicator =  diagnostics_indicator
    },

    -- Change bufferline's highlights here! See `:h bufferline-highlights` for detailed explanation.
    -- Note: If you use catppuccin then modify the colors below!
    highlights = {},
}

if vim.g.colors_name == "catppuccin" then
    local cp = require("catppuccin.palettes").get_palette() -- Get the palette.
    cp.none = "NONE" -- Special setting for complete transparent fg/bg.

    local catppuccin_hl_overwrite = {
        highlights = require("catppuccin.groups.integrations.bufferline").get({
            styles = { "italic", "bold" },
            custom = {
                mocha = {
                    -- Hint
                    hint = { fg = cp.rosewater },
                    hint_visible = { fg = cp.rosewater },
                    hint_selected = { fg = cp.rosewater },
                    hint_diagnostic = { fg = cp.rosewater },
                    hint_diagnostic_visible = { fg = cp.rosewater },
                    hint_diagnostic_selected = { fg = cp.rosewater },
                },
            },
        }),
    }

    opts = vim.tbl_deep_extend("force", opts, catppuccin_hl_overwrite)
end

require("bufferline").setup(opts)
