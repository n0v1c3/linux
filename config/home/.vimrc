""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Name: .vimrc
" Description: Configuration file that is automatically loaded and applied to Vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""
" Highlighting
""

" Preferred background
set background=dark

" Preferred color scheme
colorscheme evening

" Display relative line number along the left hand side
set relativenumber

" Syntax highlighting
filetype plugin on
syntax on

" Highlight searches
set hlsearch


""
" Numbering
""

" Display line number for current line
set number

" Highlight current line
set cursorline

" Start scrolling five lines before window border
set scrolloff=5

""
" Tabs/Indenting
""

" Enable plugins for indentation
filetype plugin indent on

set tabstop=4
set softtabstop=4
set shiftwidth=4

""
" Display
""

" Show 'invisible' characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

""
" Spelling
""

" Turn on spell check
setlocal spell spelllang=en_us

" Custom spell-check list
set spellfile=~/.vim/spell/wordlist.utf-8.add

""
" Plugins
""

" Enable case auto-indent plugin
let g:sh_indent_case_labels=1

""
" Mappings
""

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
" Commands
""

command INDENT args **/* **/.* | argdo execute "normal gg=G" | update
command TODO vimgrep TODO **/* **/.* | cw
