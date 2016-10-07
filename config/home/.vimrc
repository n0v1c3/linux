" Name: .vimrc
" Desc: Configuration file that is automatically loaded and applied to Vim

set nocompatible

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
" Abbreviations {{{
" clean code {{{
iabbrev <cr> <CR>
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
iabbrev rne RN Engineering
iabbrev RNE RN Engineering
iabbrev SDK Shutdown Key
iabbrev tatg travis.gall@gmail.com
iabbrev tatr tgall@rnengineering.com
iabbrev tgall Travis Gall
iabbrev tx transmitter
iabbrev txs transmitters
iabbrev Tx Transmitter
iabbrev Txs Transmitters

iabbrev Mon Monday
iabbrev Tue Tuesday
iabbrev Wed Wednsday
iabbrev Thu Thursday
iabbrev Fri Friday
iabbrev Sat Saturday
iabbrev Sund Sunday
iabbrev Jan January
iabbrev Feb February
iabbrev Mar March
iabbrev Apr April
iabbrev Jun June
iabbrev Jul July
iabbrev Aug August
iabbrev Sept September
iabbrev Oct October
iabbrev Nov November
iabbrev Dec December
iabbrev mon Monday
iabbrev tue Tuesday
iabbrev wed Wednsday
iabbrev thu Thursday
iabbrev fri Friday
iabbrev sat Saturday
iabbrev sund Sunday
iabbrev jan January
iabbrev feb February
iabbrev mar March
iabbrev apr April
iabbrev jun June
iabbrev jul July
iabbrev aug August
iabbrev sept September
iabbrev oct October
iabbrev nov November
iabbrev dec December
" }}}
" }}}
" Colouring {{{
" 256 colors
set t_Co=256

" Preferred background
set background=dark

" Preferred color scheme
colorscheme desert

" Autohotkey
au BufNewFile,BufRead *.ahk setf autohotkey
" }}}
" Commands {{{
" Indent all files recursively in current directory
command! INDENT args **/* **/.* | argdo execute "normal gg=G" | update

" Find all TODO's recursively in current directory
command! TODO vimgrep /TODO \[\d\d\d\d\d\d\]/ **/* **/.* | cw
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
" Editor {{{
" Backspace over autoindent, line breaks, start of insert
set backspace=indent,eol,start
" }}}
" Folding {{{
set foldenable
set foldlevelstart=0
set foldnestmax=10
set foldmethod=indent
set foldlevel=2
set foldcolumn=3

" Enable vim to check for modelines throughout your files (best practice to
" keep them at the top or the bottom of the file
set modeline

" Number of modelines to be checked, if set to zero then modeline checking
" will be disabled
set modelines=5
" :set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
" }}}
" Functions {{{
" Markdown {{{
" Disable markdown "mode"
function MarkdownDisable()
	" Remove page width
	set colorcolumn=0
	" Disable spell checking
	set nospell
endfunction

function MarkdownEnable()
	" Mark page width
	set colorcolumn=80
	" Enable spell checking
	setlocal spell spelllang=en_us
endfunction

" Underline the current line for markdown documents
function MarkdownHeader(level)
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
			" TODO [161007] - Adjust for last line in the document
			" Replace "-" with leading "#"
			execute "normal! mmjddkI### \<ESC>`m"
		elseif @t == "#"
			execute "normal! mmI#\<ESC>`m"
		else
			" TODO [161007] - Can this be cleaner?
			" Insert h1
			execute "normal! :call MarkdownHeader(1)\<CR>"
		endif
	elseif a:level == 1
		normal! mmyypv$r=`m
	elseif a:level == 2
		normal! mmyypv$r-`m
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
" Spelling {{{
" TODO [161006] - Add last misspelled word to a custom dictionary
" Correct the last incorrect word and return to same position
function SpellingLastWrongWord()
	normal! mm[s1z=`m
endfunction
" Correct the last incorrect word and return to same position
function SpellingNextWrongWord()
	normal! mm]s1z=`m
endfunction
" }}}
" Word Count {{{
let g:word_count="<unknown>"

function WordCount()
	return g:word_count
endfunction

" Update the value of g:word_count with the current number of words in the
" file
function UpdateWordCount()
	" Reset line count
	let lnum = 1
	" Reset word count
	let n = 0
	" For each line
	while lnum <= line('$')
		" Update the number of words
		let n = n + len(split(getline(lnum)))
		" Update the number of lines
		let lnum = lnum + 1
	endwhile
	" Update system value
	let g:word_count = n
endfunction

" Update the count when cursor is idle in command or insert mode
" Update when idle for 1000 msec (default is 4000 msec)
set updatetime=1000
augroup WordCounter
	au! CursorHold,CursorHoldI * call UpdateWordCount()
augroup END
"}}}
" }}}
" Highlighting {{{
" Highlighting for the width of the page (moved to MarkdownEnable())
"set colorcolumn=80

" Syntax highlighting
filetype plugin on
syntax on

" Highlight current line
set cursorline

" Search as characters are entered
set incsearch

" Highlight searches
set hlsearch

" Keep the manual folding highlighting
highlight CommentClose ctermbg=DarkGrey guibg=DarkGrey ctermfg=230  guifg=lavender 
highlight CommentOpen ctermbg=DarkGrey guibg=DarkGrey ctermfg=230  guifg=lavender 
autocmd BufRead,BufNewFile * syntax match CommentClose /\".*{{{/
autocmd BufRead,BufNewFile * syntax match CommentOpen /\"\ }}}/
" }}}
" Mappings {{{
" Leader key {{{
let mapleader="\<space>"
" }}}
" dotfiles {{{
" Open vimrc file in split view
nnoremap <leader>et :sp ~/.tmux.conf<CR>

" Open vimrc file in split view
nnoremap <leader>ev :sp ~/.vimrc<CR>

" Open zshrc file in split view
nnoremap <leader>ez :sp ~/.zshrc<CR>

" Source vimrc into current session
nnoremap <leader>sv :so ~/.vimrc<CR>
" }}}
" Case {{{
noremap <leader>cU viwU
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
nnoremap <leader>o :NERDTreeToggle<CR>
" }}}
" File management {{{
noremap <leader>q gg=G:wq<CR>
" }}}
" Folding {{{
nnoremap <leader><leader> za
" }}}
" Highlight {{{
nnoremap <leader>hn :noh<CR>
" }}}
" Indent {{{
noremap <leader>gg gg=G<C-o><C-o>
" }}}
" Markdown {{{
nnoremap <leader>md :call MarkdownDisable()<CR>
nnoremap <leader>me :call MarkdownEnable()<CR>
nnoremap <silent><leader>mh :<C-u>call MarkdownHeader(v:count)<CR>
" }}}
" Navigation {{{
noremap <up> <NOP>
noremap <down> <NOP>
noremap <left> <NOP>
noremap <right> <NOP>
noremap j gj
noremap k gk

" NO more substitution use cl (Change Letter)
noremap s <NOP>

" Scroll Up
noremap <silent><leader>k 15<C-Y>
" Scroll Down
noremap <silent><leader>j 15<C-E>
" }}}
" Screen {{{
nnoremap <C-L> :noh<CR><C-L>
" }}}
" Search {{{
vnoremap <leader>/ y/<C-R>"<CR>
" }}}
" Sorting {{{
vnoremap <leader>sm :'<,'>sort -M
" }}}
" Spelling {{{
nnoremap <leader>spl :call SpellingLastWrongWord()
nnoremap <leader>spn :call SpellingNextWrongWord()

" }}}
" TODO {{{
noremap <leader>ti ITODO [<C-R>=strftime("%y%m%d")<CR>] - <CR><C-c>k:cal NERDComment(0,"toggle")<CR>A
noremap <leader>tc :TODO<CR>
" }}}
" Typos {{{
" }}}
" Visual {{{
noremap v" vi"
noremap v' vi'
" }}}
" Window {{{
nnoremap <silent> <leader>w <C-w>w
nnoremap <leader>wv :vertical resize -5<CR>
nnoremap <leader>wV :vertical resize +5<CR>
nnoremap <leader>wh :resize -5<CR>
nnoremap <leader>wH :resize +5<CR>
" }}}
" Yank {{{
map Y y$
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
" Searching {{{
" Ignore case of given search terms
set ignorecase

" Only search for matching capitals when they are used
set smartcase
" }}}
" Spelling {{{
" Turn on spell check (moved to MarkdownEnable())
"setlocal spell spelllang=en_us

" Custom spell-check list
set spellfile=~/.vim/spell/wordlist.utf-8.add
" }}}
" Statusline {{{
" Set statusline
highlight User1 ctermbg=black guibg=black ctermfg=blue guifg=blue
" Highlight User1*%modified%file %type%=%word, %line, %percent
set statusline=%1*%M%<%t\ %y%=%{WordCount()},\ %l/%L,\ %P
" }}}
" Tabs/Indenting {{{
" Enable plugins for indentation
filetype plugin indent on

" Set tab width
set tabstop=4
set softtabstop=4
set shiftwidth=4
" }}}

" vim: foldmethod=marker:foldlevel=0

