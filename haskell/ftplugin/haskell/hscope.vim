set cscopeprg=hscope

" hscope
"
if has('cscope')
    set csto=0
    set cst
    set nocsverb
    if filereadable("hscope.out")
        cs add hscope.out
    elseif $HSCOPE_DB != ""
        cs add $HSCOPE_DB
    endif
    set csverb
endif
