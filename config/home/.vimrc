""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Name: .vimrc
" Description: Configuration file that is automatically loaded and applied to Vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

execute pathogen#infect()

""
" Highlighting
""

" TODO [160928] - Add highlighting for the width of the page (can be toggled on, off by default)

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
let g:NERDTreeWinPos="right"

""
" Mappings
""

" Disable arrow keys for navigation
noremap <up> <NOP>
inoremap <up> <NOP>
vnoremap <up> <NOP>

noremap <down> <NOP>
inoremap <down> <NOP>
vnoremap <down> <NOP>

noremap <left> <NOP>
inoremap <left> <NOP>
vnoremap <left> <NOP>

noremap <right> <NOP>
inoremap <right> <NOP>
vnoremap <right> <NOP>

" Save file or visual selection with Ctrl+W
noremap <silent><C-w> :update<CR>
inoremap <silent><C-w> <C-C>:update<CR>a
vnoremap <silent><C-w> <C-O>:update!<CR>

""
" Commands
""

" TODO [160928] - Create command or mapping to quickly insert a new TODO

command INDENT args **/* **/.* | argdo execute "normal gg=G" | update
command TODO vimgrep TODO **/* **/.* | cw
