nnoremap <silent><M-right> :BufferLineCycleNext<CR>
nnoremap <silent><M-left> :BufferLineCyclePrev<CR>

" These commands will move the current buffer backwards or forwards in the bufferline
nnoremap <silent><M-S-right> :BufferLineMoveNext<CR>
nnoremap <silent><M-S-left> :BufferLineMovePrev<CR>

" These commands will sort buffers by directory, language, or a custom criteria
nnoremap <silent><Leader>tse :BufferLineSortByExtension<CR>
nnoremap <silent><Leader>tsd :BufferLineSortByDirectory<CR>
nnoremap <silent><Leader>tsi :lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>
