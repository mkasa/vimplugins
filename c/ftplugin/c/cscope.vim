
" cscope
"
if has('cscope')
    set csto=0
    set nocst
    set nocsverb
    set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif
