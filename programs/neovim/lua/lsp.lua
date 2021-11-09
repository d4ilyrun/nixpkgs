local nvim_lsp = require('lspconfig')

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd' }
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

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 5, max_item_count = 5 },
  },
  formatting = {
    with_text = true,
    menu = {
      buffer = "[buf]",
      nvim_lsp = "[LSP]",
      path = "[path]",
      luasnip = "[snip]",
    },
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
}

require('lspkind').init({
    with_text = true,
    preset = 'codicons',

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

