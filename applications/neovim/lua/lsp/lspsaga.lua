-- lspsaga
local lspsaga = require 'lspsaga'

lspsaga.setup {
  debug = true,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  diagnostic_header_icon = "   ",

  -- code action title icon
  code_action_icon = " ",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },

  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },

  rename_prompt_prefix = "➤",
  rename_output_qflist = {
    enable = false,
    auto_open_qflist = false,
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<CR>",
  },

  border_style = "single",
  definition_preview_icon = "  ",
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
  diagnostic_message_format = "%m %c",
  highlight_prefix = false,
}

local map = vim.api.nvim_set_keymap

map("n", "gr", "<cmd>Lspsaga rename<cr>", {silent = true, noremap = true})
map("n", "gd", "<cmd>Lspsaga preview_definition<cr>", {silent = true, noremap = true})
map("n", "gs", ":<c-u>Lspsaga signature_help<cr>", {silent = true, noremap = true})
map("n", "gi", ":<c-u>Lspsaga lsp_finder<cr>", {silent = true, noremap = true})
map("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", {silent = true, noremap = true})

map("n", "<a-cr>", "<cmd>Lspsaga code_action<cr>", {silent = true, noremap = true})
map("v", "<a-cr>", "<cmd>Lspsaga range_code_action<cr>", {silent = true, noremap = true})

map("n", "<Leader><a-cr>", "<cmd>Lspsaga open_floaterm<cr>", {silent = true, noremap = true})
map("t", "<a-cr>", "<cmd>Lspsaga close_floaterm<cr>", {silent = true, noremap = true})

map("n", "<C-Up>", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {silent = true, noremap = true})
map("n", "<C-Down>", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent = true, noremap = true})

map("n", "K",  "<cmd>Lspsaga hover_doc<cr>", {silent = true, noremap = true})
map("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
map("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})

