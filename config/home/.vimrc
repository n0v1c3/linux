""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Name: .vimrc
" Description: Configuration file that is automatically loaded and applied to Vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""
" Plugins
""

" Pathogen
execute pathogen#infect()

" Enable case auto-indent plugin
let g:sh_indent_case_labels=1

" NERDTree
" Open to right
let g:NERDTreeWinPos="right"

" NERDCommenter
let g:NERDSpaceDelims=1

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

let mapleader="\<space>"
noremap <up> <NOP>
noremap <down> <NOP>
noremap <left> <NOP>
noremap <right> <NOP>
noremap c" ci"
noremap c' ci'
noremap <leader>cq :cclose<CR>
noremap <leader>co :copen<CR>
nnoremap dd dd
nnoremap d" di"
nnoremap d' di'
noremap <leader>gg gg=G<C-o><C-o>
noremap j gj
noremap <leader>j 10j
noremap k gk
noremap <leader>k 10k
noremap <leader>nh :noh<CR>
noremap <leader>o :NERDTree<CR>
map q: :q
noremap <leader>q gg=G:wq<CR>
noremap <leader>s :update<CR>
" TODO [161001] - Not working for indented (always back 1 indent)
noremap <leader>ti I<CR><ESC>kiTODO [<C-R>=strftime("%y%m%d")<CR>] - <C-c>:call NERDComment(0,"toggle")<CR>A
noremap <leader>tc :TODO<CR>
noremap v" vi"
noremap v' vi'
noremap <leader>w <C-w>w
vnoremap <leader>/ y/<C-R>"<CR>
imap -=- <C-c>

""
" Commands
""

" Indent all files recursively in current directory
command! INDENT args **/* **/.* | argdo execute "normal gg=G" | update

" Find all TODO's recursively in current directory
command! TODO vimgrep /TODO \[\d\d\d\d\d\d\]/ **/* **/.* | cw
