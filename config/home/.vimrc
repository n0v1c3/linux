" Preferred background
set background=dark

" Preferred color scheme
colorscheme evening

" Display relative line number along the left hand side
set relativenumber

" Display line number for current line
set number

" Turn on spell check
setlocal spell spelllang=en_us

" Enable case auto-indent plugin
let g:sh_indent_case_labels=1

" Disable arrow keys for navigation
imap <up> <NOP>
imap <down> <NOP>
imap <left> <NOP>
imap <right> <NOP>

map <up> <NOP>
map <down> <NOP>
map <left> <NOP>
map <right> <NOP>

""
" Plugins
""

" Enable plugins for indentation
filetype plugin indent on
set smartindent

""
" Bash
""

" Add auto indent for case
let g:sh_indent_case_labels=1
