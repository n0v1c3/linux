" File: cleanup.vim
" Description: Keep your files clean easily as you go
" Authors: Travis Gall
" Notes:
" TODO-TJG [171106] - Add auto ADD rows where required (manage fold markers)

" Functions {{{1
" Remove trailing blank lines
function! RemoveLines()
    " Remove adjacent lines
    execute "normal! :%s/\\n\\{3,}/\\r\\r/e\<CR>"
    " TODO [171105] - Remove blank lines from the begining of file
    " Remove lines from the end of the file
    execute "normal! :%s/\\($\\n\\s*\\)\\\+\\%$//e\<CR>"
endfunction

" Remove trailing spaces
function! RemoveSpaces()
    execute "normal! :%s/\\s\\\+$//e\<CR>"
endfunction

function! AutoIndent()
    execute 'normal! gg=G'
endfunction

" Clean the current file
function! CleanFile()
    call AutoIndent()
    call RemoveSpaces()
    call RemoveLines()
endfunction

" Commands {{{1
command! CleanFile call CleanFile()
