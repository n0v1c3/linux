" Name: user.vim
" Description: TODO code
" Authors: Travis Gall
" Notes:

" TODO [171104] - Need escape sequence
" Get a string input from the user
function! UserInput(prompt)
    " Get input from user
    call inputsave()
    let reply=input(a:prompt)
    call inputrestore()
    
    " Return the user's reply
    return l:reply
endfunction
