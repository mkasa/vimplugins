" guard
if exists('g:loaded_syntastic_yaml_kwalifycheck_checker')
    finish
endif
let g:loaded_syntastic_yaml_kwalifycheck_checker = 1

" save cpo
let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_yaml_kwalifycheck_IsAvailable() dict
    return executable(self.getExec())
endfunction

function! SyntaxCheckers_yaml_kwalifycheck_GetHighlightRegex(item)
    " TODO
    return ''
endfunction

function! SyntaxCheckers_yaml_kwalifycheck_GetLocList() dict
    let makeprg = self.makeprgBuild({
                \ 'args': '',
                \ 'args_after': '' })

    let errorformat =
        \ '%-GSyntax OK,' .
        \ '%E%f:%l:%c:%m'
    let env = {}

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'env': env })
endfunction

" Add to the Syntastic Registry
call g:SyntasticRegistry.CreateAndRegisterChecker({
            \ 'filetype': 'yaml',
            \ 'name': 'kwalifycheck',
            \ 'exec': 'kwalify-check'})

" Add to a list
if !exists('g:syntastic_yaml_checkers')
    let g:syntastic_yaml_checkers = ['kwalifycheck']
endif

" restore cpo
let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
