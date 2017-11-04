" Name: todos.vim
" Description: TODO based functions and keymaps
" Author: Travis Gall
" Notes:

" Functions {{{
" List all TODOs in the CWD
function! GetTODOs()
    " TODO [171103] - These should be permenent to VIM?!?
    " Binary files that can be ignored
    set wildignore+=*.jpg,*.docx,*.xlsm,*.mp4
    " Seacrch the CWD to find all of your current TODOs
    vimgrep /TODO \[\d\d\d\d\d\d\]/ **/* **/.* | cw 5
    " Un-ignore the binary files
    set wildignore-=*.jpg,*.docx,*.xlsm,*.mp4
endfunction

" Insert a new TODOs
function SetTODO()
    " Get input from user for the TODOs string
    call inputsave()
    let todo=input('What is your TODO? ')
    call inputrestore()
    
    " Return the TODOs string
    return 'TODO [' . strftime('%y%m%d') . '] - ' . todo
endfunction
" }}} Functions
" Keymaps {{{
nnoremap <silent> <leader>tf :call GetTODOs()<CR>
nnoremap <silent> <leader>ti mmO<C-c>:call setline('.',SetTODO())<CR>:call NERDComment(0,'toggle')<CR>==`m
" }}} Keymaps
