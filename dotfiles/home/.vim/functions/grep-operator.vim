"nnoremap <silent> <leader>g <c-s>:silent execute "grep! -R " . shellescape(expand("<cword>")) . " ."<cr>:copen 5<cr><c-w>k<c-l><c-q>
" TODO-TJG [171108] - Restore cursor position for normal mode
nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
vnoremap <leader>g mm:<c-u>call GrepOperator(visualmode())<cr>`m

" Grep operator function
function! GrepOperator(type)
    " Select text based on type
    if a:type ==# 'v'
        execute 'normal! `<v`>y'
    elseif a:type ==# 'char'
        execute 'normal! `[v`]y'
    else
        return
    endif

    " Echo last yank
    " echom shellescape(@@)

    " Grep and display results
    silent execute 'grep! -R ' . shellescape(@@) . ' .'
    copen 5

    " Clean-up mangled screen and return to window
    execute "normal! \<c-l>\<c-w>w"
endfunction
