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
" Source all bundles with pathogen
execute pathogen#infect()

" CtrlP
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_working_path_mode = 'ra'

" NERDCommenter
let g:NERDSpaceDelims=1 " One space after auto comment

" Syntastic configuration
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Lint checkers
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
source ~/.vim/functions/navigation.vim
source ~/.vim/functions/todos.vim
source ~/.vim/functions/users.vim
source ~/.vim/functions/windows.vim

" Section: Configurations {{{1
" Wildignore {{{2
set wildignore+=*.swp

" StatusLine {{{2
" TODO-TJG [171106] - Broken in help files
highlight StatusLine ctermbg=darkgreen ctermfg=white
highlight StatusLineNC ctermbg=black ctermfg=lightgreen
set statusline=%m%r%h                   " Flags
set statusline+=%t                      " Filename
set statusline+=\ %{GetFoldStrings()}   " Folds
set statusline+=%=                      " Right side of statusline
set statusline+=\|%2B\|                 " Cursor value in HEX
set statusline+=%3l/%3L\|               " Current line

" Format Options {{{2
set formatoptions-=cro

" Auto Indent {{{2
set smartindent     " Auto indent enabled
set tabstop=4       " Number of spaces in tab character
set softtabstop=4   " Number of spaces tabs count for while editing
set shiftwidth=4    " Auto indent spaces
set expandtab       " Expand all tabs into spaces

" Custom file types
" AutoHotKey
au BufNewFile,BufRead *.ahk setf autohotkey
" }}}
" Tabs/Indenting {{{2
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Section: Autocommands {{{1
" Python {{{2
augroup Python
    autocmd!
    autocmd! FileType python setlocal nosmartindent
augroup END

" Help files {{{2
augroup Help
    autocmd!
    autocmd! FileType help nnoremap <buffer> <esc> :q<cr>
    autocmd! Filetype help nnoremap <buffer> <cr> <c-j>
    autocmd! Filetype help nnoremap <buffer> <c-j> <c-j>
    autocmd! Filetype help nnoremap <buffer> <bs> <c-t>
    autocmd! Filetype help nnoremap <buffer> o /'\l\{2,\}'<CR>
    autocmd! Filetype help nnoremap <buffer> O ?'\l\{2,\}'<CR>
    autocmd! Filetype help nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>
    autocmd! Filetype help nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>
augroup END

" Section: Key Mappings {{{1
" Insert Mappings {{{2
" VIM {{{3
inoremap <silent> <c-u> <esc>mmviwU`ma
inoremap <silent> <down> <nop>
inoremap <silent> <left> <nop>
inoremap <silent> <right> <nop>
inoremap <silent> <up> <nop>
inoremap <silent> jk <esc>mm:call CleanFile()<cr><esc>`mzzl

" Normal Mappings {{{2
" VIM {{{3
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>sv :mapclear<cr>:source $MYVIMRC<cr>:set nohlsearch<cr>lh
nnoremap <silent> H ^
nnoremap <silent> K i<cr><esc>
nnoremap <silent> L $
nnoremap <silent> gf :e <cfile><cr>
nnoremap <silent> p ]p
noremap <silent> <esc> <c-s>mm:call CleanFile()<cr>`mzz<c-q><esc>

" Autofill {{{3
noremap <leader>x <c-x>

" Clean-Up {{{3
nnoremap <silent><leader>cf mm:CleanFile<cr>`m
nnoremap <silent> <c-u> mmviwU`m

" Comments {{{3
nnoremap <silent> <leader>ct :call NERDComment(0,'toggle')<cr>

" CtrlP {{{3
nnoremap <silent> <c-p> :CtrlPMRUFiles<cr>

" Files {{{3
nnoremap <leader>fs <c-w>sgf
nnoremap <leader>fv <c-w>vgf

" Folding {{{3
" TODO-TJG [171105] - Add mapping for NERDTree (zo/zc open/close dirs)
nnoremap <silent> <leader><leader> za
noremap <silent> <leader>zz :call WrapFold(v:count)<cr>
noremap <silent> <leader>zj :call WrapFold(foldlevel(line(".")) + 1)<cr>
noremap <silent> <leader>zk :call WrapFold(foldlevel(line(".")) - 1)<cr>
" TODO-TJG [171105] - This looks like a function waiting to happen
noremap <silent> zO mmggvGzO`m
noremap <silent> zC mmggvGzC`m

" Highlighting {{{3
nnoremap <silent> <leader>hd :nohlsearch<cr>
nnoremap <silent> <leader>he :set hlsearch<cr>

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

" TODOs {{{3
" TODO-TJG [171106] - This should be a function
nnoremap <silent> <leader>tf /TODO-<cr>
nnoremap <silent> <leader>tg mm:call GetTODOs()<cr>`m
nnoremap <silent> <leader>ti mmO<C-c>:call setline('.',SetTODO('TJG'))<cr>:call NERDComment(0,'toggle')<cr>==`m
nnoremap <silent> <leader>tt :call TakeTODO('TJG')<cr>

" Windows {{{3
noremap <leader>w <c-w>
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
