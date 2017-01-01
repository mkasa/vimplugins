
function! GotoSpecifiedChar() abort
    let l:chr = nr2char(getchar())
    let l:cur_line = line('.')
    if 1 < l:cur_line
        let l:cur_col = col('.')
        let l:prev_line = strpart(getline(l:cur_line - 1), l:cur_col)
        let l:pat = '\v(.{-})'
        if l:chr ==# '(' || l:chr ==# ')' || l:chr ==# '.' || l:chr ==# '[' || l:chr ==# ']' || l:chr ==# '$' || l:chr ==# '^' || l:chr ==# '\\'
            let l:pat = l:pat . "\\" . l:chr
        else
            let l:pat = l:pat . l:chr
        endif
        let [l:res, l:stpos, l:edpos] = matchstrpos(l:prev_line, l:pat)
        if l:edpos != -1
            call feedkeys(repeat(' ', l:edpos))
        endif
    endif
endfunction
