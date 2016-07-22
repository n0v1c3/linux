""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Name: .vimrc
" Description: Configuration file that is automatically loaded and applied to Vim
" TODO (160720) - Clean-up this file (see "Tabs/Indenting")
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Preferred background
set background=dark

" Preferred color scheme
colorscheme evening

" Display relative line number along the left hand side
set relativenumber

" Syntax highlighting
filetype plugin on
syntax on

" Display line number for current line
set number

" Highlight current line
set cursorline

""
" Tabs/Indenting
" TODO (160720) - Single var for all tab widths
""

" Enable plugins for indentation
filetype plugin indent on

set tabstop=4
set softtabstop=4
set shiftwidth=4

" Show 'invisible' characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

" Highlight searches
set hlsearch

" Start scrolling five lines before window border
set scrolloff=5

" Turn on spell check
setlocal spell spelllang=en_us

" Custom spell-check list
set spellfile=~/.vim/spell/wordlist.utf-8.add

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

command INDENT args **/* **/.* | argdo execute "normal gg=G" | update
command TODO vimgrep TODO **/* **/.* | cw
