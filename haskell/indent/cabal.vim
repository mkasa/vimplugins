"" provides indentation for cabal

if exists('b:did_indent')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

let b:did_indent = 1

setlocal indentexpr=GetCabalIndent(v:lnum)
setlocal indentkeys=!^F,o,O,<CR>
setlocal nosmartindent

function! GetCabalIndent(lnum)
    if a:lnum == 0
        return 0
    endif
    let l:prev_line = getline(a:lnum - 1)
    if l:prev_line =~# '\v,\s*$'
        let l:m = matchlist(l:prev_line, '\v^(.{-0,}:\s*)\S')
        if 0 < len(l:m)
            return len(l:m[1])
        else
            return indent(a:lnum - 1)
        endif
    endif
    return indent(a:lnum - 1)
endfunction

let &cpo = s:save_cpo
