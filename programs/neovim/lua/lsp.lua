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

