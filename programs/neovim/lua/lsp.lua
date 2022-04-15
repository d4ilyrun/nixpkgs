local nvim_lsp = require('lspconfig')

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'pyright', 'ocamllsp', 'rnix' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

require('lspkind').init({
    mode = 'symbol_text',
    preset = 'default',

    symbol_map = {
      -- Classic
      Text = "",
      Keyword = "",
      Function = "",
      Variable = "",
      Operator = "",
      Value = "",
      Constant = "",
      Struct = "ﴯ",
      Enum = "",
      EnumMember = "",

      -- OOP
      Constructor = "",
      Method = "",
      Field = "ﰠ",
      Property = "ﰠ",
      Class = "ﴯ",
      Interface = "",
      Module = "",
        
      -- Extras
      Unit = "塞",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      Event = "",
      TypeParameter = ""
    },
})

-- Custom diagnostic symbols
local colors = require("tokyonight.colors").setup({})
local signs = { Error = " ", Warn = " ", Hint = "", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Treesitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require('lspfuzzy').setup {} -- go to references through fzf
