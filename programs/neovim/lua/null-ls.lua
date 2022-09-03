local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions


null_ls.setup {
  debug = false,
  sources = {
      -- cf: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
      -- formatting.clang_format,
      -- diagnostics.cppcheck,
      code_actions.statix,
  },

  on_attach = function(client)

      if client.server_capabilities.document_formatting then
          vim.cmd([[
          augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
          augroup END
          ]])
      end
  end,
}

 -- to format C/C++ files while waiting for a fix
vim.cmd([[autocmd BufWritePost *.h,*.hh,*.hpp,*.hxx,*.c,*.cc,*.cpp silent :!clang-format -i %]])
