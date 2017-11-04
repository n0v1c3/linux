" Name: .vimrc
" Description: Custom Vim configurations
" Author: Travis Gall
" Notes:
" - Spelling download en_u
"   > ftp://ftp.vim.org/pub/vim/runtime/spell/

" Set leader to <SPACE>
let g:mapleader="\<space>"

" Plugins {{{
" Third-Party {{{
" Pathogen source all Vim bundles found in ~/.vim/bundle
execute pathogen#infect()
" Case Auto-Indent enable
let g:sh_indent_case_labels=1
" NERDTree open to right
let g:NERDTreeWinPos='left'
" NERDCommenter add a space after auto comment
let g:NERDSpaceDelims=1

" Syntastic
set statusline=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_php_checkers = ['php', '/bin/phplint']
let g:syntastic_sh_checkers = ['bashate', 'sh', 'shellcheck']
let g:syntastic_sh_shellcheck_args = '--external-sources'
let g:syntastic_vim_checkers = ['vimlint', 'vint']
" }}} Third-Party
" Local {{{
source ~/.vim/functions/todos.vim
" }}} Local
" }}} Plugins
" Custom Functions {{{1
" Search {{{2

" Search current buffer for matching pattern and display in c-window
function! FindFunc(...)
    " Close the c-window in order for it it be in focus once re-opened
    cclose
    " Underline current cursor position within current document
    set cursorline
    " Move cursor to next pattern match
    call search(a:1)
    " Record line and column position into "p
    let @p=line('.').' col '.col('.')
    " Put Results into c-window
    silent execute 'vimgrep /'.a:1.'/gj '.fnameescape(expand('%')) | cw
    " Update search register
    let @/=a:1
    " Find line and column position in c-window list
    call search(@p)
    " Jump to that record
    exe "normal \<CR>"
    " Set focus to the c-window
    botright cwindow
    " Underline current cursor position within c-window
    set cursorline
endfunction

" Clean-up {{{2

" Remove all trailing spaces, ignore errors
function! TrimFile()
    execute "normal! :%s/\\s\\\+$//e\<CR>"
endfunction

" C-Window {{{2

" Open c-window while maintaining the cursor line
function! COpenCursor()
    " Enable cursorline in main window
    set cursorline
    " Open all folds for current result
    silent! foldopen!
    " Open c-window
    botright cwindow
    " Enable cursorline in c-window
    set cursorline
endfunction

" Close c-window and clean-up cursor line
function! CCloseCursor()
    " Close c-window
    cclose
    " Open all folds for current result
    silent! foldopen!
    " Remove cursor line from main window
    set nocursorline
endfunction
function! CToggleCursor()
    if &buftype!=#'quickfix'
        call COpenCursor()
    else
        call CCloseCursor()
    endif
endfunction
function! WinEnter()
    if &buftype!=#'quickfix'
        set nocursorline
    endif
endfunction

" Markdown {{{2

" Disable markdown "mode"
function! MarkdownDisable()
    " Remove page width
    set colorcolumn=0
    " Disable spell checking
    set nospell
endfunction
function! MarkdownEnable()
    " Mark page width
    set colorcolumn=80
    " Enable spell checking
    setlocal spell spelllang=en_u
endfunction
" Underline the current line for markdown document
function! MarkdownHeader(level)
    echom a:level
    if a:level ==# ''
        " Read character from line below
        normal! mmjv"ry`m
        " Read the first word on the current line
        normal! mm^v"ty`m
        " Adjust function for current heading status
        if @r ==# '='
            " Replace "=" with "-"
            normal! mmj^v$r-`m

        elseif @r ==# '-'
            " Replace "-" with leading "#"
            execute "normal! mmjdd`mI; ### \<ESC>`m"

        elseif @t ==# '#'
            execute "normal! mm02l#\<ESC>`m"
        else
            " Insert h1
            execute "normal! :call MarkdownHeader(1)\<CR>"
        endif
    elseif a:level == 1
        normal! mmyypv$r=$x`m
    elseif a:level == 2
        normal! mmyypv$r-$x`m
    else
        " Set mark at current courser position, move to beginning of line
        normal! mm^
        " Insert header
        execute 'normal!' a:level . "i#\<ESC>a "
        " Return to mark
        normal! `m
    endif
endfunction

" Word Count {{{2

" Store running count
let g:word_count='<unknown>'
" Calculate the number of words in a document
function! WordCount()
    return g:word_count
endfunction
" Update the value of g:word_count with the current number of words in the file
function! UpdateWordCount()
    " Reset line count
    let lnum = 1
    " Reset word count
    let n = 0
    " For each line
    while lnum <= line('$')
        " Update the number of word
        let n = n + len(split(getline(lnum)))
        " Update the number of line
        let lnum = lnum + 1
    endwhile
    " Update system value
    let g:word_count = n
endfunction
" Update the count when cursor is idle in command or insert mode
augroup WordCounter
    au! CursorHold,CursorHoldI * call UpdateWordCount()
augroup END

" Custom Commands {{{1
" Comments {{{2

" Toggle comments for current line
command! Comment call NERDComment(0,"toggle")

" TODO {{{2
 
" Find all TODO's recursively in current directory
"command! TODO vimgrep /TODO \[\d\d\d\d\d\d\]/ **/* **/.* | cw 5

" Search {{{2

" Search for string in current file and put results in QuickFix window
command! -nargs=+ -complete=command Find call FindFunc(<q-args>) | set hls

" Key Mappings {{{1
" Re-binds {{{2

" Find
nnoremap <C-f> :Find<SPACE>

" Folding
nnoremap zC mmggVGzC`m
nnoremap zO mmggVGzO`m

" Navigarion
noremap j gj
noremap k gk

" Yank to end of line
nnoremap Y y$

" Leader key {{{2

" Edit common documents
nnoremap <silent> <leader>eb :sp ~/.bashrc<CR><C-W>o
nnoremap <silent> <leader>ei :sp ~/.config/i3/config<CR><C-W>o
nnoremap <silent> <leader>ep :sp ~/.pythonrc<CR><C-W>o
nnoremap <silent> <leader>es :sp ~/.shrc<CR><C-W>o
nnoremap <silent> <leader>et :sp ~/.tmux.conf<CR><C-W>o
nnoremap <silent> <leader>ev :sp ~/.vimrc<CR><C-W>o
nnoremap <silent> <leader>ex :sp ~/.xinitrc<CR><C-W>o
nnoremap <silent> <leader>ez :sp ~/.zshrc<CR><C-W>o

" Folding
nnoremap <silent> <leader><leader> za

" Highlighting
nnoremap <silent> <leader>hd :noh<CR>
nnoremap <silent> <leader>he :set hls<CR>

" NERDTree
nnoremap <silent> <leader>o :NERDTreeToggle<CR>

" NERDComment
nnoremap <silent> <leader>ct :Comment<CR>

" Source vimrc
nnoremap <silent> <leader>sv :so ~/.vimrc<CR>

" Window
nnoremap <silent> <leader>w <C-w>

" C-Window {{{2

augroup cwindow
    " Remove underline from document when leaving Quickfix List
    autocmd WinEnter * call WinEnter()

    " Automatic navigation while in c-window
    autocmd FileType qf map <buffer> <CR> <CR>:call CCloseCursor()<CR>
    autocmd FileType qf map <buffer> G G<CR>:call COpenCursor()<CR>
    autocmd FileType qf map <buffer> gg gg<CR>:call COpenCursor()<CR>
    autocmd FileType qf map <buffer> j j<CR>:call COpenCursor()<CR>
    autocmd FileType qf map <buffer> k k<CR>:call COpenCursor()<CR>
augroup END

" Navigation of c-window results
noremap <silent> <leader>cj :cn<CR>:call COpenCursor()<CR>
noremap <silent> <leader>ck :cp<CR>:call COpenCursor()<CR>

" Toggle c-window
nnoremap <silent> <leader>cc :call CToggleCursor()<CR>

" Syntax {{{1
" Global {{{2

" Visual auto complete for command menu
set wildmenu
" Show command in bottom bar
set showcmd
" Do not redraw during operations such as macro
set lazyredraw
" Always display the status line even if only one window is displayed
set laststatus=2
" Display hidden char
let g:display_hidden = 'hidden'
" Change cursor to | and _ for insert and replace modes respectively
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
" Backspace over auto indent, line breaks, start of insert
set backspace=indent,eol,start
" Update when idle for 1000 msec (default is 4000 msec)
set updatetime=500
" Virtual editing, position cursor where there is are no characters (all modes)
set virtualedit=all
" Ignore file patterns globally
set wildignore+=*.swp
" Change default location of the .viminfo cache file
set viminfo+=n~/.vim/.viminfo

" Folding
set foldenable
set foldlevelstart=0
set foldnestmax=10
set foldmethod=marker
set foldlevel=0
set foldcolumn=3

" Enable modelines
set modeline
set modelines=5

" Display line numbers relative to the current line
set relativenumber
" Display line number for current line
set number
" Start scrolling five lines before window border
set scrolloff=5

" 256 color
set t_Co=256
" Preferred background
set background=dark
" Preferred color scheme
colorscheme koehler

" Disable automatic text wrapping
set textwidth=0

" General settings required for highlighting
filetype plugin indent on
syntax on

" Do smart auto indenting when starting a new line
set smartindent

" Set tab width
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Expand all tabs
set expandtab

" Custom spell-check list
set spellfile=~/.vim/spell/wordlist.utf-8.add

" Underline misspelled words
highlight clear SpellBad
highlight SpellBad cterm=underline

augroup commenting
    " Remove automatic commenting
    autocmd Filetype * setlocal formatoptions-=r
    autocmd Filetype * setlocal formatoptions-=o
    autocmd FileType * set formatoptions-=c
augroup END

" Ignore case unless capitals used, highlight and search as modified
set ignorecase
set smartcase
set hlsearch
set incsearch

" Set output to statusline
highlight User1 ctermbg=black guibg=black ctermfg=blue guifg=blue
set statusline+=%1*%M%<%t\ %y%=%{WordCount()},\ %l/%L,\ %P
set showcmd

" Python {{{2

augroup python
    " Disable smartindent for python scripting
    autocmd! FileType py setlocal nosmartindent
augroup END

" Templates {{{1

" Load template based on current file extension (:help template)
augroup templates
    " Remove ALL auto commands for the current group
    autocmd!
    " Expand file extension and search templates placing content at top of file
    autocmd BufNewFile *.* silent! execute '0r ~/.vim/templates/skeleton.'.expand('<afile>:e')
    " Substitute equations between the VIM_EVAL and END_EVAL equations
    autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END

" TESTING {{{1

" " Fold all code only displaying the commenting
" setlocal foldmethod=expr
" setlocal foldexpr=GetPotionFold(v:lnum)
" 
" " TODO [170806] - Handle indented commenting
" function! GetPotionFold(lnum)
"     if getline(a:lnum) =~? '^\s*\"'
"         return '0'
"     else
"         return '1'
" endfunction
