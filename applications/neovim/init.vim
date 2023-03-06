""""""""""""""""""""""""""""""""""""""
" => Settings
"""""""""""""""""""""""""""""""""""""""
let mapleader = ","			    " Leader key
set clipboard+=unnamedplus
set number relativenumber		" Line numbering
set nohlsearch                  " No highlight
set ignorecase                  " Case Insensitive search
set smartcase
set nobackup                    " No backup files
set nowrap
set encoding=UTF-8

"""""""""""""""""""""""""""""""""""
" => File explorer   
"""""""""""""""""""""""""""""""""""""""
:nnoremap <C-e> :NvimTreeOpen<CR>
:nnoremap <C-p> :Telescope find_files<CR>

"""""""""""""""""""""""""""""""""""""""
" => Theme
"""""""""""""""""""""""""""""""""""""""
syntax on
set t_Co=256
set termguicolors

" start screen
let g:startify_custom_header = [
            \
            \ ' ██╗   ██╗██╗███╗   ███╗',
            \ ' ██║   ██║██║████╗ ████║',
            \ ' ██║   ██║██║██╔████╔██║',
            \ ' ╚██╗ ██╔╝██║██║╚██╔╝██║',
            \ '  ╚████╔╝ ██║██║ ╚═╝ ██║',
            \ '   ╚═══╝  ╚═╝╚═╝     ╚═╝',
          \]

"""""""""""""""""""""""""""""""""""""""
" => statusbar
"""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""
" => Code sytling
"""""""""""""""""""""""""""""""""""""""
set tabstop=4
set shiftwidth=4
set expandtab
set scrolloff=10

au FileType Makefile setlocal noexpandtab
au FileType nix setlocal tabstop=2 shiftwidth=2 expandtab

"""""""""""""""""""""""""""""""""""""""
" => Keymaps
"""""""""""""""""""""""""""""""""""""""
" edit / reload vim.rc
nnoremap <Leader>ve :e $MYVIMRC<CR>			" edit
nnoremap <Leader>vr :source $MYVIMRC<CR>	" reload

" tabs
set hidden

nnoremap <leader>tt :enew<cr>
nnoremap <leader>td :bdelete<cr>
nmap <M-right>  :bnext<cr>
nmap <M-left>   :bprev<cr>
nmap <Leader>tl :ls<cr>

" windows
nmap <M-up>    :tabnext<cr>
nmap <M-down>  :tabprev<cr>

nnoremap <C-M-up>       :resize +1<cr>
nnoremap <C-M-down>     :resize -1<cr>
nnoremap <C-M-right>    :vertical resize +3<cr>
nnoremap <C-M-left>     :vertical resize -3<cr>
