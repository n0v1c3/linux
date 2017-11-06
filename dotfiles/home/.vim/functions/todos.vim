" Name: todos.vim
" Description: TODOs code
" Authors: Travis Gall
" Notes:
"   - Requires user.vim
"   - Requires NERDComment

" TODO-TJG [171103] - Need a list of binary files to ignore searching

" Data entry prompts
let g:setTodoHeader = 'TODO: '

" TODO-TJG [171105] - Test
" Functions {{{1
" TODO-TJG [171103] - Add current file ONLY option
" List all TODOs in the CWD
function! GetTODOs()
    " Binary files that can be ignored
    set wildignore+=*.jpg,*.docx,*.xlsm,*.mp4,*.vmdk
    " Seacrch the CWD to find all of your current TODOs
    vimgrep /TODO.*\[\d\{6}]/ **/* **/.* | cw 5
    " Un-ignore the binary files
    set wildignore-=*.jpg,*.docx,*.xlsm,*.mp4,*.vmdk
endfunction

" Insert a new TODOs
function! SetTODO(initials)
    " Return the TODOs string
    return 'TODO-' . a:initials .' [' . strftime('%y%m%d') . '] - ' . UserInput(g:setTodoHeader)
endfunction

" TODO-TJG [171105] - Make this more general
" Set your initials to a current TODOs
function! TakeTODO(initials)
    execute 'normal! 0f[hi-' . a:initials . "\<esc>"
endfunction
