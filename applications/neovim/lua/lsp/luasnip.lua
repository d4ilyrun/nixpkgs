-- luasnip setup
local luasnip = require 'luasnip'

require('lspkind').setup({
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

