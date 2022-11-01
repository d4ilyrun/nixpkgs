" Customize fzf colors to match your color scheme                                          
" - fzf#wrap translates this to a set of `--color` options                                 
let g:fzf_colors =                                                                         
            \ { 'fg':    ['fg', 'Normal'],                                                           
            \ 'bg':      ['bg', 'Normal'],                                                           
            \ 'hl':      ['fg', 'Comment'],                                                          
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],                             
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],                                       
            \ 'hl+':     ['fg', 'Statement'],                                                        
            \ 'info':    ['fg', 'PreProc'],                                                          
            \ 'border':  ['fg', 'Ignore'],                                                           
            \ 'prompt':  ['fg', 'Conditional'],                                                      
            \ 'pointer': ['fg', 'Exception'],                                                        
            \ 'marker':  ['fg', 'Keyword'],                                                          
            \ 'spinner': ['fg', 'Label'],                                                            
            \ 'header':  ['fg', 'Comment'] } 
