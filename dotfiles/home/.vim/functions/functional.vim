" TODO-TJG [171112] - Make work with dictionaries
" Copy list and sort
function! Sort(l)
    let new_list = deepcopy(a:l)
    call sort(new_list)
    return new_list
endfunction

" Copy list and reverse order
function! Reverse(l)
    let new_list = deepcopy(a:l)
    call reverse(new_list)
    return new_list
endfunction

" Copy list and append new value
function! Add(l, val)
    let new_list = deepcopy(a:l)
    call add(new_list, a:val)
    return new_list
endfunction

" Copy list and associate value with index
function! Accoc(l, i, val)
    let new_list = deepcopy(a:l)
    let new_list[a:i] = a:val
    return new_list
endfunction

" Copy list and remove an index
function! Remove(l, i)
    let new_list = deepcopy(a:l)
    call remove(new_list, a:i)
    return new_list
endfunction

" Copy list and 'map' each index to the passed function
function! Mapped(fn, l)
    let new_list = deepcopy(a:l)
    " v:val has the value of the 'current' index while processing
    call map(new_list, string(a:fn) . '(v:val)')
    return l:new_list
endfunction

" Filter list against passed function keeping 'truthy' results
function! Filtered(fn, l)
    let new_list = deepcopy(a:l)
    call filter(new_list, string(a:fn) . '(v:val)')
    return l:new_list
endfunction

" Filter list against passed function keeping 'falsey' results
function! Removed(fn, l)
    let new_list = deepcopy(a:l)
    call filter(new_list, '!' . string(a:fn) . '(v:val)')
    return l:new_list
endfunction
