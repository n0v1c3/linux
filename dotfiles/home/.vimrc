" File: .vimrc
" Description: Autoload file for the VIM text editor
" Authors: Travis Gall
" Notes:
" - There is an operaotor mapping in folds.vim
" TODO-TJG [171106] - GetFolds is not working in SQL files
" TODO-TJG [171106] - Sorting for folded content (sort whole blocks by fold)
" TODO-TJG [171106] - SQL lint checker

let g:mapleader="\<space>"
let g:maplocalleader='-'

" Section: Plugins {{{1
" Third-Party {{{2
" Pathogen {{{3
" Source all bundles with pathogen
execute pathogen#infect()

" CtrlP {{{3
let g:ctrlp_cmd = 'CtrlPMRU' " Most recent files
"let g:ctrlp_working_path_mode = 'ra' " Git ancestor

" NERDCommenter {{{3
let g:NERDSpaceDelims=1 " One space after auto comment

" Syntastic configuration {{{3
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers = ['php', '/bin/phplint']
let g:syntastic_sh_checkers = ['bashate', 'sh', 'shellcheck']
let g:syntastic_sh_shellcheck_args = '--external-sources'
let g:syntastic_vim_checkers = ['vimlint', 'vint']
let g:syntastic_sql_checkers = ['sqlint']

" Local {{{2
source ~/.vim/functions/abbreviations.vim
source ~/.vim/functions/cleanup.vim
source ~/.vim/functions/display.vim
source ~/.vim/functions/folds.vim
source ~/.vim/functions/grep-operator.vim
source ~/.vim/functions/navigation.vim
source ~/.vim/functions/todos.vim
source ~/.vim/functions/users.vim
source ~/.vim/functions/windows.vim

" Section: Configurations {{{1
" Auto Indent {{{2
set smartindent     " Auto indent enabled
set tabstop=4       " Number of spaces in tab character
set softtabstop=4   " Number of spaces tabs count for while editing
set shiftwidth=4    " Auto indent spaces
set expandtab       " Expand all tabs into spaces

" Folds {{{2
set foldenable
set foldcolumn=3
set foldlevel=1
set foldlevelstart=1
set foldmethod=marker
set foldnestmax=10
set foldtext=v:folddashes.FormatFoldString(v:foldstart)

" Format Options {{{2
set formatoptions-=cro

" StatusLine {{{2
" TODO-TJG [171106] - Broken in help files
highlight StatusLine    ctermbg=darkgreen ctermfg=white
highlight StatusLineNC  ctermbg=black ctermfg=lightgreen
set statusline=%m%r%h                   " Flags
set statusline+=%t                      " Filename
set statusline+=\ %{GetFoldStrings()}   " Folds
set statusline+=%=                      " Right side of statusline
set statusline+=\|%2B\|                 " Cursor value in HEX
set statusline+=%3l/%3L\|               " Current line

" Wildignore {{{2
set wildignore+=/home/travis/.vim/bundle/.*
set wildignore+=*/oh-my-zsh/.*
set wildignore+=*/.oh-my-zsh/.*
set wildignore+=*.swp

" Section: Autocommands {{{1
" AllFiles {{{2
augroup AllFiles
    autocmd!
    "autocmd! BufReadPre * execute "normal! :CleanFile\<cr>gg"
    autocmd! BufWritePre * execute "normal! mm:CleanFile\<cr>`m"
augroup END

" Python {{{2
augroup Python
    autocmd!
    autocmd! FileType python setlocal nosmartindent
augroup END

" AutoHotKey {{{2
augroup AHK
    autocmd!  BufNewFile,BufRead *.ahk setf autohotkey
augroup END

" Help files {{{2
augroup Help
    autocmd!
    autocmd! FileType help nnoremap <buffer> <esc> :q<cr>
    autocmd! Filetype help nnoremap <buffer> <cr> <c-j>
    autocmd! Filetype help nnoremap <buffer> <c-j> <c-j>
    autocmd! Filetype help nnoremap <buffer> <bs> <c-t>
augroup END

" Section: Key Mappings {{{1
" Insert Mappings {{{2
" VIM {{{3
inoremap <silent> <c-u> <esc>mmviwU`ma
inoremap <silent> <down> <nop>
inoremap <silent> <left> <nop>
inoremap <silent> <right> <nop>
inoremap <silent> <up> <nop>
inoremap <silent> jk <esc>mm`m

" Normal Mappings {{{2
" VIM {{{3
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>sv :mapclear<cr>:source $MYVIMRC<cr>:set nohlsearch<cr>
nnoremap <silent> H ^
nnoremap <silent> K i<cr><esc>
nnoremap <silent> L $
nnoremap <silent> gf :e <cfile><cr>
nnoremap <silent> p ]p
" TODO-TJG [171107] - Will not escape a 'd'
" TODO-TJG [171107] - Always starting a new vim in REPLACE mode
" noremap <silent> <esc> <c-s><esc>m:call CleanFile()<cr>`mzz<c-q><esc>

" Autofill {{{3
noremap <leader>x <c-x>

" Clean-Up {{{3
nnoremap <silent> <c-u> mmviwU`m
nnoremap <silent> <leader>; mmA;<esc>`m
nnoremap <silent> <leader>cf mm:CleanFile<cr>`m

" Comments {{{3
nnoremap <silent> <leader>ct :call NERDComment(0,'toggle')<cr>

" CtrlP {{{3
nnoremap <silent> <c-p> :CtrlPMRUFiles<cr>

" Files {{{3
nnoremap <silent> <leader>fs <c-w>sgf
nnoremap <silent> <leader>fv <c-w>vgf

" Folding {{{3
" TODO-TJG [171105] - Add mapping for NERDTree (zo/zc open/close dirs)
nnoremap <silent> <leader><leader> za
noremap <silent> <leader>zz :call WrapFold(v:count)<cr>
noremap <silent> <leader>zj :call WrapFold(foldlevel(line(".")) + 1)<cr>
noremap <silent> <leader>zk :call WrapFold(foldlevel(line(".")) - 1)<cr>
" TODO-TJG [171105] - This looks like a function waiting to happen
noremap <silent> zO mmggvGzO`m
noremap <silent> zC <c-s>mmggvGzC`m<c-q>

" Lines {{{3
" TODO [171104] - Both will not work in visual mode
" TODO [171104] - Will not work on the last line of the file
nnoremap <silent> _ ddkP
" TODO [171104] - Make function that removes usless blank lines
nnoremap <silent> - ddp

" Navigation {{{3
nnoremap <silent> <c-h> zh
nnoremap <silent> <c-j> <c-e>
nnoremap <silent> <c-k> <c-y>
nnoremap <silent> <c-l> zl
nnoremap <silent> <leader>j }
nnoremap <silent> <leader>k {
noremap <silent> <down> <nop>
noremap <silent> <left> <nop>
noremap <silent> <right> <nop>
noremap <silent> <up> <nop>

" NERDTree {{{3
nnoremap <silent> <leader>o :NERDTreeToggle<cr>

" Searching {{{3
nnoremap / :set hlsearch<cr>:set incsearch<cr>/\v
nnoremap <silent> <leader>hd :set noincearch<cr>:nohlsearch<cr>
nnoremap <silent> <leader>he :set incsearch<cr>:set hlsearch<cr>

" TODOs {{{3
" TODO-TJG [171106] - This should be a function
nnoremap <silent> <leader>tf /TODO-<cr>
nnoremap <silent> <leader>tg mm:call GetTODOs()<cr>`m
nnoremap <silent> <leader>ti mmO<C-c>:call setline('.',SetTODO('TJG'))<cr>:call NERDComment(0,'toggle')<cr>==`m
nnoremap <silent> <leader>tt :call TakeTODO('TJG')<cr>

" Windows {{{3
noremap <leader>w <c-w>
" cwindow
noremap <leader>cc :cclose<cr>
noremap <leader>cn :cnext<cr>
noremap <leader>co :copen 5<cr>
noremap <leader>cp :cprevious<cr>
" lwindow
noremap <leader>lc :lclose<cr>
noremap <leader>ln :lnext<cr>
noremap <leader>lo :lopen 5<cr>
noremap <leader>lp :lprevious<cr>
" Operator Mappings {{{2
" VIM {{{3
onoremap i_ :<c-u>normal! T_vt_<cr>

onoremap in( :<c-u>normal! f(vi(<cr>
onoremap in) :<c-u>normal! f)vi(<cr>
onoremap il( :<c-u>normal! F(vi(<cr>
onoremap il) :<c-u>normal! F)vi(<cr>

onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap in} :<c-u>normal! f}vi{<cr>
onoremap il{ :<c-u>normal! F{vi{<cr>
onoremap il} :<c-u>normal! F}vi{<cr>

onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap in] :<c-u>normal! f]vi[<cr>
onoremap il[ :<c-u>normal! F[vi[<cr>
onoremap il] :<c-u>normal! F]vi[<cr>

onoremap in< :<c-u>normal! f<vi<<cr>
onoremap in> :<c-u>normal! f>vi<<cr>
onoremap il< :<c-u>normal! F<vi<<cr>
onoremap il> :<c-u>normal! F>vi<<cr>

onoremap in" :<c-u>normal! f"lvi"<cr>
onoremap il" :<c-u>normal! F"hvi"<cr>

onoremap in' :<c-u>normal! f'lvi'<cr>
onoremap il' :<c-u>normal! F'hvi'<cr>

onoremap in@ :<c-u>execute "normal! /@\r:nohlsearch\rBvE"<cr>
onoremap il@ :<c-u>execute "normal! ?@\r:nohlsearch\rBvE"<cr>

" Section: Matchings {{{1
" Whitespace {{{2
highlight WhiteSpace ctermbg=yellow
match WhiteSpace /\v\s+$/

" Section: Test {{{1
