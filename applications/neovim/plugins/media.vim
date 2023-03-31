function! Preview()
    if Compile() == 0
        let filename = expand('%:t')
        execute "! evince '/tmp/" . filename . "' &"
    endif
endfunction

function! Compile()
	let filename = expand('%:t')
	let extension = expand('%:e')
	if extension == "ms"
		execute "! groff -ms \"%\" -T pdf > /tmp/" . filename
	elseif extension == "tex"
		execute "! pandoc -f latex -t latex \"%\" -o /tmp/" . filename
	elseif extension == "md"
		execute "! pandoc \"%\" -s -o /tmp/" . filename
	elseif extension == "pdf"
		execute "! cp -f \"%\" /tmp/'" . filename . "'"
    else
        return 1
	endif
    return 0
endfunction

" Remaps
noremap <leader>mp :call Preview()<CR><CR><CR>
noremap <leader>mc :call Compile()<CR><CR>

autocmd BufRead * silent! :call Preview()
