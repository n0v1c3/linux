""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Name: .vimrc
" Description: Configuration file that is automatically loaded and applied to Vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""
" Plugins
""

" Load bundle plugins
execute pathogen#infect()

" Enable case auto-indent plugin
let g:sh_indent_case_labels=1

" Open split-view to the right
let g:NERDTreeWinPos="right"

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
" Mappings
""

" Disable arrow keys for navigation
noremap <up> <NOP>
noremap <down> <NOP>
noremap <left> <NOP>
noremap <right> <NOP>

nnoremap <silent><space> viw
vnoremap <silent><space> va

" Do not skip wrapped lines
noremap j gj
noremap k gk

" Leader maps
let mapleader="-"
noremap <silent><leader>g gg=G<C-O>
noremap <silent><leader>s :update<CR>
noremap <silent><leader>o :NERDTree<CR>
noremap <silent><leader>q :wq<CR>
vnoremap <silent><leader>/ y/<C-R>"<CR>
noremap <silent><leader>w <C-w>w<CR>

""
" Commands
""

" TODO [160928] - Create command or mapping to quickly insert a new TODO

command! INDENT args **/* **/.* | argdo execute "normal gg=G" | update
command! TODO vimgrep TODO **/* **/.* | cw
