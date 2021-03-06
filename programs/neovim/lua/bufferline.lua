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

require("bufferline").setup{
    options = {
        close_command = "Bdelete! %d",
        right_mouse_command = "Bdelete! %d",
        left_mouse_command = "buffer %d",

        diagnostics = "nvim_lsp",
        diagnostics_indicator = diagnostics_indicator,

        show_buffer_close_icons = false,
        show_close_icons = false,

        -- Align buffer line with the bufferes when opening NvimTree
        offsets = {{filetype = "NvimTree", text = "", padding = 1}},

        always_show_bufferline = true,
    },

    highlights = {
        modified = {
            guifg = { attribute = "fg", highlight = "TabLine" },
            guibg = { attribute = "bg", highlight = "TabLine" },
        },
        modified_selected = {
            guifg = { attribute = "fg", highlight = "Normal" },
            guibg = { attribute = "bg", highlight = "Normal" },
        },
        modified_visible = {
            guifg = { attribute = "fg", highlight = "TabLine" },
            guibg = { attribute = "bg", highlight = "TabLine" },
        }, },
    }
