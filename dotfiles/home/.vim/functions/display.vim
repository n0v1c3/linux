" Name: display.vim
" Description: Display configuration, functions and mappings
" Authors: Travis Gall
" Notes:
" -

set background=dark " Dark background for theme
set hlsearch        " Highligh the search results
set lazyredraw      " Postpone screen redraw until macro completion
set t_Co=256        " 256 colour scheme

colorscheme koehler
filetype plugin indent on
syntax on

set formatoptions-=cro " Remove automatic commenting
