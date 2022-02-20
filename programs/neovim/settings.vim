""""""""""""""""""""""""""""""""""""""
" => Settings
"""""""""""""""""""""""""""""""""""""""
let mapleader = ","			    " Leader key
set clipboard=unnamedplus
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
:nnoremap <C-e> :NERDTree<CR>
:nnoremap <C-p> :FZF<CR>

"""""""""""""""""""""""""""""""""""""""
" => Theme
"""""""""""""""""""""""""""""""""""""""
syntax on
set t_Co=256
set termguicolors


"""""""""""""""""""""""""""""""""""""""
" => statusbar
"""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""
" => Code sytling
"""""""""""""""""""""""""""""""""""""""
set tabstop=4
set shiftwidth=4
set expandtab

au FileType Makefile setlocal noexpandtab
au FileType nix setlocal tabstop=2 shiftwidth=2 expandtab

"""""""""""""""""""""""""""""""""""""""
" => Keymaps
"""""""""""""""""""""""""""""""""""""""
" edit / reload vim.rc
nnoremap <Leader>ve :e $MYVIMRC<CR>			" edit
nnoremap <Leader>vr :source $MYVIMRC<CR>	" reload

" tabs
nnoremap <C-t><BS>   :tabc<CR>      " close tab
nnoremap <C-t><C-t>  :tabnew<CR>    " new tab  
nnoremap <C-t><up>   :tabr<CR>      " first tab
nnoremap <C-t><down> :tabl<CR>      " last tab
nnoremap <C-t><left> :tabp<CR>      " previous tab
nnoremap <C-t><right> :tabn<CR> " next tab
