local cmp = require 'cmp'
local luasnip = require('luasnip')

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local icons = {
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
}


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

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" })
    },

    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip'},
        { name = 'nvim_lsp_signature_help' },
        { name = 'buffer', max_item_count = 5 },
    },

    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

            vim_item.menu = ({
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                path = "[path]",
                luasnip = "[snip]",
                cmdline = "[cmd]",
            })[entry.source.name]

            return vim_item
        end,
    },

    window = {
        documentation = cmp.config.window.bordered(),
    },

    experimental = {
        native_menu = false,
        ghost_text = true,
    },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'path' },
        { name = 'cmdline' }
    }
})

require('lspfuzzy').setup {} -- go to references through fzf
