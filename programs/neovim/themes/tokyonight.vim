" Disable background
lua vim.g.tokyonight_transparent = 1

syntax on
colorscheme tokyonight

" Status line
let g:lightline = {'colorscheme': 'tokyonight'}

lua << EOF
-- require('lualine').setup {
--     options = {
--         theme = 'tokyonight'
--         }
--     }
EOF
