" +-------------------+
" | __   __ _  _   _  |
" | \ \ / /| || \ / | |
" |  \ v / | ||  v  | |
" |   \_/  |_||_|v|_| |
" |                   |
" +-------------------+

" Name: .vimrc
" Description: Configuration file that is automatically loaded and applied to Vim
" Notes:
"   - Manually download spelling files (en_u) ~ ftp://ftp.vim.org/pub/vim/runtime/spell/

" Plugins {{{
" Pathogen source all Vim bundles found in ~/.vim/bundle
execute pathogen#infect()
" Case Auto-Indent enable
let g:sh_indent_case_labels=1
" NERDTree open to right
let g:NERDTreeWinPos="left"
" NerdCommenter add a space after auto comment
let g:NERDSpaceDelims=1
" }}}
" Abbreviations {{{
" clean code {{{
iabbrev cr CR
" }}}
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
iabbrev @@ travis.gall@gmail.com
" }}}
" }}}
" Colouring {{{
" 256 color
set t_Co=256
" Preferred background
set background=dark
" Preferred color scheme
colorscheme koehler
" AutoHotKey
au BufNewFile,BufRead *.ahk setf autohotkey
" }}}
" Commands {{{
" Find all TODO's recursively in current directory
command! TODO vimgrep /TODO \[\d\d\d\d\d\d\]/ **/* **/.* | cw 5
" }}}
" Display {{{
" Visual auto complete for command menu
set wildmenu
" Show command in bottom bar
set showcmd
" Do not redraw during operations such as macro
set lazyredraw
" Always display the status line even if only one window is displayed
set laststatus=2
" Display hidden char
let g:display_hidden = "hidden"
" }}}
" Editor {{{
" Backspace over auto indent, line breaks, start of insert
set backspace=indent,eol,start
" Remove vi compatibility
set nocompatible
" Update when idle for 1000 msec (default is 4000 msec)
set updatetime=1000
" Virtual editing, position cursor where there is are no characters (all modes)
set virtualedit=all
" Ignore file patterns globally
set wildignore+=*.swp
" }}}
" Folding {{{
set foldenable
set foldlevelstart=0
set foldnestmax=10
set foldmethod=indent
set foldlevel=2
set foldcolumn=3
" Enable Vim to check for modelines throughout your files (best practice to
" keep them at the top or the bottom of the file
set modeline
" Number of modelines to be checked, if set to zero then modeline checking
" will be disabled
set modelines=5
" }}}
"Functions {{{
" Display {{{
function! DisplayHidden()
    " Hide useless character
    if g:display_hidden == "hidden"
        set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
        let g:display_hidden = ""
    else
        set lcs=tab:\ \ ,trail:·,nbsp:_
        let g:display_hidden = "hidden"
    endif
endfunction
" }}}
" Markdown {{{
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
    if a:level == ""
        " Read character from line below
        normal! mmjv"ry`m
        " Read the first word on the current line
        normal! mm^v"ty`m
        " Adjust function for current heading status
        if @r == "="
            " Replace "=" with "-"
            normal! mmj^v$r-`m

        elseif @r == "-"
            " Replace "-" with leading "#"
            execute "normal! mmjdd`mI; ### \<ESC>`m"

        elseif @t == "#"
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
        execute "normal!" a:level . "i#\<ESC>a "
        " Return to mark
        normal! `m
    endif
endfunction
" }}}
" Save {{{
" Clean-up code on save
function! SaveCode()
    " Remove all trailing spaces ignore errors
    execute "normal! :%s/\\s\\\+$//e\<CR>"
endfunction
" }}}
" Spelling {{{
" Add last misspelled word to a custom dictionary
function! SpellingAddLastWrongWord()
    execute "normal! mm[szg`m\<CR>"
endfunction
" Add next misspelled word to a custom dictionary
function! SpellingAddNextWrongWord()
    execute "normal! mm]szg`m\<CR>"
endfunction
" Correct the last incorrect word and return to same position
function! SpellingFixLastWrongWord()
    execute "normal! mm[s1z=`m\<CR>"
endfunction
" Correct the last incorrect word and return to same position
function! SpellingFixNextWrongWord()
    execute "normal! mm]s1z=`m\<CR>"
endfunction
" }}}
" Visual {{{
function! BlockMove(direction)
    " Get the current lines and columns from the visual mark
    let start_line = line("'<")
    let start_col = col("'<")
    let end_line = line("'>")
    let end_col = col("'>")
    " Adjust offset for repositioning the visual marks '<,'>
    if a:direction == "right"
        " Move block RIGHT
        let col_offset = 1
    elseif a:direction == "left"
        " Move block LEFT
        let col_offset = -1
    endif
    " Set visual marks positions {expr}, {list [buffer,line,column,off]}
    call setpos("'<", [0,start_line,start_col+col_offset,0])
    call setpos("'>", [0,end_line,end_col+col_offset,0])
endfunction
" }}}
" Word Count {{{
" Store running count
let g:word_count="<unknown>"
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
" }}}
" }}}
" Mappings {{{
" Leader key {{{
let mapleader="\<space>"
" }}}
" Dotfiles {{{
" Open i3 config file in split view
nnoremap <leader>ei :sp ~/.config/i3/config<CR>
" Open tmux config file in split view
nnoremap <leader>et :sp ~/.tmux.conf<CR>
" Open vimrc file in split view
nnoremap <leader>ev :sp ~/.vimrc<CR>
" Open zshrc file in split view
nnoremap <leader>ez :sp ~/.zshrc<CR>

" Source i3 into current session
nnoremap <leader>si :! i3-msg reload<CR>
" Source tmux into current session
nnoremap <leader>st :! tmux source-file ~/.tmux.conf<CR>
" Source vimrc into current session
nnoremap <leader>sv :so ~/.vimrc<CR>
" Source zshrc into current session
nnoremap <leader>sz :! source ~/.zshrc<CR>
" }}}
" Case {{{
" Set word to lowercase
noremap <leader>u viwu
" Set word to uppercase
noremap <leader>U viwU
" Toggle the case of each letter in a word
noremap <leader>~ viw~
" }}}
" C window {{{
noremap <leader>cc :cclose<CR>
noremap <leader>co :copen 5<CR>
" }}}
" File system {{{
nnoremap <leader>o :NERDTreeToggle<CR>
" }}}
" File management {{{
noremap <leader>q mmgg=G'm:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>:wq<CR>
" }}}
" Folding {{{
" Toggle the section of the current line marker
nnoremap <leader><leader> za
" Close all folded sections
nnoremap zC mmggVGzC'm
" Open all folded sections
nnoremap zO mmggVGzO'm
" }}}
" Help {{{
nnoremap <leader>? mmyiw:help <C-R>"<CR>'m
" }}}
" Hidden {{{
nnoremap <leader>hs :call DisplayHidden()<CR>
" }}}
" Highlight {{{
nnoremap <leader>hd :noh<CR>
nnoremap <leader>he :set hls<CR>
" }}}
" Indent {{{
" Indent entire file and return to current line
nnoremap <leader>I mmgg=G'm
" }}}
" Markdown {{{
nnoremap <leader>md :call MarkdownDisable()<CR>
nnoremap <leader>me :call MarkdownEnable()<CR>
nnoremap <silent><leader>mh :<C-u>call MarkdownHeader(v:count)<CR>
" }}}
" Navigation {{{
" Do not automatically adjust for line wrapping
noremap j gj
noremap k gk
" Scroll Up
noremap <silent><leader>k 15<C-Y>
" Scroll Down
noremap <silent><leader>j 15<C-E>
" }}}
" Search {{{
nnoremap <leader>/ viwy/<C-R>"<CR>
vnoremap <leader>/ y/<C-R>"<CR>
" }}}
" Snippets {{{
nnoremap <leader>snc :call SnipClass()<CR>
nnoremap <leader>snf :call SnipFunction()<CR>
nnoremap <leader>sni :call SnipIf()<CR>
" }}}
" Sorting {{{
vnoremap <leader>sm :'<,'>sort -M
" }}}
" Spelling {{{
nnoremap <leader>sal :call SpellingAddLastWrongWord()<CR>
nnoremap <leader>san :call SpellingAddNextWrongWord()<CR>
nnoremap <leader>sfl :call SpellingFixLastWrongWord()<CR>
nnoremap <leader>sfn :call SpellingFixNextWrongWord()<CR>
" }}}
" TODO {{{
noremap <leader>ti ITODO [<C-R>=strftime("%y%m%d")<CR>] - <CR><C-c>k:cal NERDComment(0,"toggle")<CR>A
noremap <leader>tI A<CR><CR>TODO [<C-R>=strftime("%y%m%d")<CR>] - <C-c>:cal NERDComment(0,"toggle")<CR>A
noremap <leader>tf :TODO<CR>
" }}}
" Visual {{{
" Block move right
vnoremap <RIGHT> xlP:call BlockMove("right")<CR>gv
" Block move left
vnoremap <LEFT> xhP:call BlockMove("left")<CR>gv
" }}}
" Window {{{
nnoremap <silent> <leader>w <C-w>
nnoremap <leader>wv :vertical resize -5<CR>
nnoremap <leader>wV :vertical resize +5<CR>
nnoremap <leader>wh :resize -5<CR>
nnoremap <leader>wH :resize +5<CR>
" }}}
" Yank {{{
nnoremap Y y$
" }}}
" }}}
" Numbering {{{
" Display relative line number along the left hand side
set relativenumber
" Display line number for current line
set number
" Start scrolling five lines before window border
set scrolloff=5
" }}}
" File Management {{{
" Read {{{
autocmd BufReadPre .vimrc execute "normal mmgg=G'm"
" }}}
" Write {{{
" Clean-up for code files prior to save
autocmd BufWritePre .vimrc call SaveCode()
" Auto indent on file open (keep files clean)
autocmd BufWritePre vimrc execute "normal mmgg=G'm"
" }}}
" }}}
" Searching {{{
" Ignore case of given search term
set ignorecase
" Only search for matching capitals when they are used
set smartcase
" }}}
" Snippets {{{
" The beginning of another snippet plugin
" Class {{{
function! SnipClass()
    if &filetype == "php"
        execute "normal! oclass  {\<CR>public function __construct() {\<CR>}\<CR>}\<ESC>kkk^t{" | startinsert
    endif
endfunction
" }}}
" Function {{{
function! SnipFunction()
    if &filetype == "vim"
        execute "normal! ofunction \<CR>endfunction\<ESC>k" | startinsert!
    elseif &filetype == "sh"
        execute "normal! ofunction \<CR>{\<CR>}\<ESC>kk" | startinsert!
    endif
endfunction
" }}}
" If {{{
function! SnipIf()
    if &filetype == "php"
        execute "normal! o// IF\<CR>\<ESC>^Diif () {\<CR>}\<ESC>kf)" | startinsert
    elseif &filetype == "vim"
        execute "normal! o\" IF\<CR>\<ESC>^Diif \<CR>endif\<ESC>k" | startinsert!
    endif
endfunction
" }}}
" }}}
" Spelling {{{
" Custom spell-check list
set spellfile=~/.vim/spell/wordlist.utf-8.add
" }}}
" Statusline {{{
" Set statusline
highlight User1 ctermbg=black guibg=black ctermfg=blue guifg=blue
" Highlight User1*%modified%file %type%=%word, %line, %percent
set statusline=%1*%M%<%t\ %y%=%{WordCount()},\ %l/%L,\ %P
" }}}
" Syntax {{{
" Disable automatic text wrapping
set textwidth=0

" General settings requried for highlighting
filetype plugin on
syntax on
" Highlight current line
set cursorline
" Search as characters are entered
set incsearch
" Highlight search
set hlsearch

" Automatic commentting
" Remove automatic insert comment leader after hitting <Enter>
autocmd Filetype * setlocal formatoptions-=r
" Remove automatic insert the current comment leader after hitting 'o' or 'O'
autocmd Filetype * setlocal formatoptions-=o
" Remove automatic commenting on text wrap
autocmd FileType * set formatoptions-=c
" }}}
" Tabs/Indenting {{{
" Enable plug-ins for indentation
filetype plugin indent on
" Do smart auto indenting when starting a new line
set smartindent
" Set tab width
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Expand all tab
set expandtab
" }}}
" Templates {{{
" Load template based on current file extension (:help template)
augroup templates
    " Remove ALL auto commands for the current group
    autocmd!
    " Expand file extension and search templates placing content at top of file
    autocmd BufNewFile *.* silent! execute '0r ~/.vim/templates/skeleton.'.expand("<afile>:e")
    " Substitute equations between the VIM_EVAL and END_EVAL equations
    autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END
" }}}

" Override the default foldmethod in this file
" vim: foldmethod=marker:foldlevel=0
