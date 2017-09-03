
" hscope
"
if has('cscope')
    set cscopeprg=do_at_stack_root\ hscope
    set csto=0
    set nocst
    set nocsverb
    set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
    if filereadable("hscope.out")
        cs add hscope.out
    elseif $HSCOPE_DB != ""
        cs add $HSCOPE_DB
    endif
    set csverb
    " autocmd BufWritePost *.hs execute 'silent !do_at_stack_root hscope `do_at_stack_root hxt -f -X` -b ' . expand('<afile>:p') . ' > /dev/null'
endif
