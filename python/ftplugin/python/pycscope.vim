
" hscope
"
if has('cscope')
    " set cscopeprg=pycscope
    set csto=0
    set nocst
    set nocsverb
    set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
    if filereadable("cscope.out")
        cs add cscope.out
    elseif $PYCSCOPE_DB != ""
        cs add $PYCSCOPE_DB
    endif
    set csverb
    " autocmd BufWritePost *.py execute 'silent !pycscope ' . expand('<afile>:p')
endif
