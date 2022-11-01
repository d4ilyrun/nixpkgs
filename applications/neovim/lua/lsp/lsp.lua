-- This file has now become useless as I set up my LSP servers through lsp-install
-- But I keep it anyway as reference and as it might still prove useful later

local nvim_lsp = require('lspconfig')

-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'pyright', 'tsserver', 'nil_ls' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
    }
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
