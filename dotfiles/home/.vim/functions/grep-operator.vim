" Name: grep-operator.vim
" Description: Create a grep 'verb' and map to <leader>g
" Authors: Travis Gall
" Notes:
" - s: and <SID> used to keep functions within 'this' namespace
" - Original command:
"     nnoremap <silent> <leader>g <c-s>:silent execute "grep! -R " . shellescape(expand("<cword>")) . " ."<cr>:copen 5<cr><c-w>k<c-l><c-q>

" TODO-TJG [171108] - Restore cursor position for normal mode
nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

" Grep operator verb
function! s:GrepOperator(type)
    " Save modified environment settings
    " TODO-TJG [171110] - Why won't this work?
    execute 'normal! mm'
    let l:window_save = winnr()
    let l:yank_save = @@

    " Select text based on type
    if a:type ==# 'v'
        " Visual selection
        normal! `<v`>y
    elseif a:type ==# 'char'
        " g@{motion}
        normal! `[y`]
    else
        " Invalid for grep (Visual block and line are included in this group)
        return
    endif

    " Grep current directory and display results
    silent execute 'grep! -R ' . shellescape(@@) . ' .'
    copen 5

    " Restore modified environment settings
    let @@ = l:yank_save
    execute l:window_save . 'wincmd w'
    execute 'normal! `m'

    " Clean-up mangled screen and return to window
    " TODO-TJG [171109] - Return to previous window properly
    execute "normal! \<c-l>"
endfunction
