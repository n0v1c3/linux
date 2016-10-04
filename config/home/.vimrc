" ==============================================================================
" Name: .vimrc
" Desc: Configuration file that is automatically loaded and applied to Vim
" ==============================================================================

" ====================
" Plugins
" ====================
" {{{
" --------------------
" Pathogen
" --------------------
execute pathogen#infect()

" --------------------
" Case Auto-Indent
" --------------------
" Enable case auto-indent plugin
let g:sh_indent_case_labels=1

" --------------------
" NERDTree
" --------------------
" Open to right
let g:NERDTreeWinPos="left"

" --------------------
" NERDCommenter
" --------------------
let g:NERDSpaceDelims=1
" }}}

" ====================
" Highlighting
" ====================
" {{{
" Highlighting for the width of the page
set colorcolumn=80

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
" }}}

" ====================
" Numbering
" ====================
" {{{
" Display line number for current line
set number

" Highlight current line
set cursorline

" Start scrolling five lines before window border
set scrolloff=5
" }}}

" ====================
" Tabs/Indenting
" ====================
" {{{
" Enable plugins for indentation
filetype plugin indent on

" Set tab width
set tabstop=4
set softtabstop=4
set shiftwidth=4
" }}}

" ====================
" Folding
" ====================
" {{{
set foldmethod=marker
set foldnestmax=10
set foldlevel=2

"This will make a fold out of paragraphs separated by blank lines:
" :set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
" }}}

" ====================
" Display
" ====================
" {{{
" Show 'invisible' characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" }}}

" ====================
" Spelling 
" ==================== 
" {{{ 
" Turn on spell check
setlocal spell spelllang=en_us
" Custom spell-check list
 set spellfile=~/.vim/spell/wordlist.utf-8.add
" }}}
" ==================== 
" Mappings
" ====================
" {{{
" --------------------
" Leader key
" --------------------
let mapleader="\<space>"

" --------------------
" Change
" --------------------
noremap c" ci"
noremap c' ci'

" --------------------
" C window
" --------------------
noremap <leader>cq :cclose<CR>
noremap <leader>co :copen<CR>

" --------------------
" Delete
" --------------------
nnoremap dd dd
nnoremap d" di"
nnoremap d' di'

" --------------------
" File system
" --------------------
nnoremap <leader>o :NERDTree<CR>

" --------------------
" File management
" --------------------
noremap <leader>q gg=G:wq<CR>
noremap <leader>s :update<CR>

" --------------------
" Highlight
" --------------------
noremap <leader>hn :noh<CR>

" --------------------
" Indent
" --------------------
noremap <leader>gg gg=G<C-o><C-o>

" --------------------
" Navigation
" --------------------
noremap <up> <NOP>
noremap <down> <NOP>
noremap <left> <NOP>
noremap <right> <NOP>
noremap j gj
noremap <leader>j jjjjjjjjjjjjjjj
noremap k gk
noremap <leader>k kkkkkkkkkkkkkkk

" --------------------
" Search
" --------------------
vnoremap <leader>/ y/<C-R>"<CR>

" --------------------
" TODO
" --------------------
noremap <leader>ti ITODO [<C-R>=strftime("%y%m%d")<CR>] - <CR><C-c>k:cal NERDComment(0,"toggle")<CR>A
noremap <leader>tc :TODO<CR>

" --------------------
" Typos
" --------------------
map q: :q

" --------------------
" Visual
" --------------------
noremap v" vi"
noremap v' vi'

" --------------------
" Window
" --------------------
nnoremap <leader>w <C-w>w
nnoremap <leader>wv :vertical resize -5<CR>
nnoremap <leader>wV :vertical resize +5<CR>
nnoremap <leader>wh :resize -5<CR>
nnoremap <leader>wH :resize +5<CR>
" }}}

" ====================
" Commands
" ====================
" {{{
" Indent all files recursively in current directory
command! INDENT args **/* **/.* | argdo execute "normal gg=G" | update

" Find all TODO's recursively in current directory
command! TODO vimgrep /TODO \[\d\d\d\d\d\d\]/ **/* **/.* | cw
" }}}
