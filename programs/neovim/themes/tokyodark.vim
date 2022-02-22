let g:tokyodark_transparent_background = 1
let g:tokyodark_enable_italic_comment = 1
let g:tokyodark_enable_italic = 1
let g:tokyodark_color_gamma = "1.0"

syntax on
colorscheme tokyodark

lua << EOF
require('lualine').setup {
    options = {
        theme = 'tokyodark'
        }
    }
EOF
