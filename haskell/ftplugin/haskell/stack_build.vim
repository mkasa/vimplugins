
setlocal makeprg=stack\ build
setlocal errorformat=%f:%l:%v:%m

"" See https://www.ishiy.xyz/posts/2015-11-29-vim-haskell.html

function! ExecOnStack() "{{{
    let l:input_arg = inputdialog(">", s:prev_stack_arg, '<<')
    if l:input_arg ==# '<<'
        return
    endif
    let s:prev_stack_arg = l:input_arg
    call execute("!stack exec -- " . l:input_arg, "")
endfunction "}}}

nnoremap <buffer> <space>: :call ExecOnStack()<Cr>
let s:prev_stack_arg=''
