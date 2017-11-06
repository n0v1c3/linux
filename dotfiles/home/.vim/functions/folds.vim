" Name: folds.vim
" Description: Folding code
" Authors: Mike Boiko, and Travis Gall
" Notes:
"   - Requires user.vim
"   - Requires NERDComment plugin
"   - Do not try to fold in this file.

" TODO [171103] - Decrease/Increase current fold level
" - Deacrease could move the current fold outside the parent fold
" - Increase could increase the number of the current fold and children

" Data entry prompts
let g:prompt_wrapFold = 'Fold: '

" Configurations
set foldenable
set foldcolumn=3
set foldlevel=1
set foldlevelstart=1
set foldmethod=marker
set foldnestmax=10
set foldtext=v:folddashes.FormatFoldString(v:foldstart)

" Create a fold on the current line(s)
function! WrapFold(foldlevel) range
    let foldlevel = a:foldlevel
    if l:foldlevel == 0
        let foldlevel = foldlevel(line('.'))
        if l:foldlevel == 0
            let foldlevel = 1
        endif
    endif

    " User entered fold name
    let prompt = UserInput(g:prompt_wrapFold)

    " Add section for first level folds
    if l:foldlevel == 1
        let prompt = 'Section: ' . l:prompt
    endif

    " TODO-TJG [171105] - This will still fold over multiple sections/sub-sections
    " Prevent folding on seperate levels
    let foldLevelFirst = foldlevel(a:firstline)
    let foldLevelLast = foldlevel(a:lastline)
    if len(getline(a:firstline, a:lastline)) == 0 || l:foldLevelFirst != l:foldLevelLast
        return '' " No lines selected
    endif

    " Wrap selection with fold
    execute 'normal! mm'
    execute 'normal! ' . a:firstline . 'GO' . prompt . ' {{{' . l:foldlevel . "\<ESC>:call NERDComment(0,'toggle')\<CR>"
    execute 'normal! `m'
endfunction

" TODO-TJG [171105] - Remove 'Section: ' from the first fold levels
" Make the status string a list of all the folds
function! GetFoldStrings()
    " Iterate through each fold level and add fold string to list
    let foldStringList = []
    let i = 1
    while i <= foldlevel('.')
        " Append string to list
        call add(foldStringList, FormatFoldString(GetLastFoldLineNum(i)))
        let i += 1
    endwhile

    " Add each fold line to status string
    let statusString = ''
    for i in foldStringList
        let statusString = statusString.'|'.i
    endfor

    return statusString.'|'
endfunction

" Get the text of the last fold
function! GetLastFoldString()
    return FormatFoldString(GetLastFoldLineNum(foldlevel('.'))).'|'
endfunction

" Format fold string so it looks neat
function! FormatFoldString(lineNum)
    " Get the line string of the current fold and remove special chars
    let line = getline(a:lineNum)
    " Remove programming language specific words
    let line = RemoveFiletypeSpecific(line)
    " Remove special (comment related) characters and extra spaces
    let line = RemoveSpecialCharacters(line)
    return line
endfunction

" Get the line number of last Fold
function! GetLastFoldLineNum(foldLvl)
    " Only search current line for fold marker
    let line = search('{{{'.a:foldLvl,'n',line('.'))
    " Search backwards for fold marker
    if l:line == 0
        let line = search('{{{'.a:foldLvl,'bn')
    endif
    return line
endfunction

" Remove special (comment related) characters and extra spaces
function! RemoveSpecialCharacters(line)
    " Remove speacial characters
    let text = substitute(a:line, '<!--\|-->\|\"\|#\|;\|/\*\|\*/\|//\|{{{\d\=', '', 'g')
    " Replace 2 or more spaces with a single space
    let text = substitute(text, ' \{2,}', ' ', 'g')
    " Remove leading and trailing spaces
    let text = substitute(text, '^\s*\|\s*$', '', 'g')
    " Remove text between () in functions
    let text = substitute(text, '(\(.*\)', '()', 'g')
    " Add nice padding
    return ' '.text.' '
endfunction

" Remove programming language specific words
function! RemoveFiletypeSpecific(line)
    let text = a:line
    if (&ft==?'python')
        " Functions/Classes
        let text = substitute(a:line, '\<def\>\|\<class\>', '', 'g')
    elseif  (&ft==?'cs')
        " Functions/Events
        let text = substitute(a:line, '\<void\>\|\<string\>\|\<bool\>\|\<private\>\|\<public\>\s', '', 'g')
    endif
    return text
endfunction

onoremap if :<c-u>execute "normal! ?{{{\r:nohlsearch\r0wvt{"<cr>

" vim: foldmethod=manual:foldlevel=4:foldlevelstart=4
