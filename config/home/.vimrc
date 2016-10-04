" vim: foldmethod=marker:foldlevel=0

" Name: .vimrc
" Desc: Configuration file that is automatically loaded and applied to Vim

" Plugins {{{
" Pathogen source all vim bundles found in ~/.vim/bundle
execute pathogen#infect()

" Case Auto-Indent enable
let g:sh_indent_case_labels=1

" NERDTree open to right
let g:NERDTreeWinPos="left"

" NerdCommenter add a space after auto comments
let g:NERDSpaceDelims=1
" }}}

" Editor {{{
" Backspace over autoindent, line breaks, start of insert
set backspace=indent,eol,start
" }}}

" Colouring {{{
" Preferred background
set background=dark

" Preferred color scheme
colorscheme desert
" }}}

" Highlighting {{{
" Highlighting for the width of the page
set colorcolumn=80

" Syntax highlighting
filetype plugin on
syntax on

" Highlight current line
set cursorline

" Search as characters are entered
set incsearch

" Highlight searches
set hlsearch
" }}}

" Numbering {{{
" Display relative line number along the left hand side
set relativenumber

" Display line number for current line
set number

" Start scrolling five lines before window border
set scrolloff=5
" }}}

" Tabs/Indenting {{{
" Enable plugins for indentation
filetype plugin indent on

" Set tab width
set tabstop=4
set softtabstop=4
set shiftwidth=4
" }}}

" Folding {{{
set foldenable
set foldlevelstart=0
set foldnestmax=10
set foldmethod=indent
set foldlevel=2

" Enable vim to check for modelines throughout your files (best practice to
" keep them at the top or the bottom of the file
set modeline

" Number of modelines to be checked, if set to zero then modeline checking
" will be disabled
set modelines=5
" :set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
" }}}

" Display {{{
" Visual Autocomplete for command menu
set wildmenu

" Show command in bottom bar
set showcmd

" Do not redraw during operations such as macros
set lazyredraw

" Show 'invisible' characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

" Always display the status line even if only one window is displayed
set laststatus=2
" }}}

" Searching {{{
" Ignore case of given search terms
set ignorecase

" Only search for matching capitals when they are used
set smartcase
" }}}

" Spelling {{{
" Turn on spell check
setlocal spell spelllang=en_us

" Custom spell-check list
 set spellfile=~/.vim/spell/wordlist.utf-8.add
" }}}

" Mappings {{{
" Leader key {{{
let mapleader="\<space>"
" }}}

" Change {{{
noremap c" ci"
noremap c' ci'
" }}}

" C window {{{
noremap <leader>cq :cclose<CR>
noremap <leader>co :copen<CR>
" }}}

" Delete {{{
nnoremap dd dd
nnoremap d" di"
nnoremap d' di'
" }}}

" File system {{{
nnoremap <leader>o :NERDTree<CR>
" }}}

" File management {{{
noremap <leader>q gg=G:wq<CR>
noremap <leader>s :update<CR>
" }}}

" Folding {{{
nnoremap <leader>f za
" }}}

" Highlight {{{
nnoremap <leader>hn :noh<CR>
" }}}

" Indent {{{
noremap <leader>gg gg=G<C-o><C-o>
" }}}

" Navigation {{{
noremap <up> <NOP>
noremap <down> <NOP>
noremap <left> <NOP>
noremap <right> <NOP>
noremap j gj
noremap <leader>j jjjjjjjjjjjjjjj
noremap k gk
noremap <leader>k kkkkkkkkkkkkkkk
" }}}

" Search {{{
vnoremap <leader>/ y/<C-R>"<CR>
" }}}

" TODO {{{
noremap <leader>ti ITODO [<C-R>=strftime("%y%m%d")<CR>] - <CR><C-c>k:cal NERDComment(0,"toggle")<CR>A
noremap <leader>tc :TODO<CR>
" }}}

" Typos {{{
map q: :q
" }}}

" Yank {{{
map Y y$
" }}}

" Visual {{{
noremap v" vi"
noremap v' vi'
" }}}

" Window {{{
nnoremap <leader>w <C-w>w
nnoremap <leader>wv :vertical resize -5<CR>
nnoremap <leader>wV :vertical resize +5<CR>
nnoremap <leader>wh :resize -5<CR>
nnoremap <leader>wH :resize +5<CR>
" }}}

" Screen {{{
nnoremap <C-L> :noh<CR><C-L>
" }}}

" dotfiles {{{
nnoremap <leader>ev :sp ~/.vimrc<CR>
nnoremap <leader>ez :sp ~/.zshrc<CR>
nnoremap <leader>sv :so ~/.vimrc<CR>
" }}}
" }}}

" Abbreviations {{{
" common typos {{{
iabbrev abit a bit
iabbrev acess access
iabbrev abd and
iabbrev adn and
iabbrev teh the
iabbrev tehn then
iabbrev waht what
" }}}
" short-hand {{{
iabbrev rne RN Engineering
iabbrev tx transmitter
iabbrev txs transmitters
iabbrev Tx Transmitter
iabbrev Txs Transmitters
" }}}
" }}}

" Commands {{{
" Indent all files recursively in current directory
command! INDENT args **/* **/.* | argdo execute "normal gg=G" | update

" Find all TODO's recursively in current directory
command! TODO vimgrep /TODO \[\d\d\d\d\d\d\]/ **/* **/.* | cw
" }}}
