
let s:source = {
      \ 'name' : 'kwalifycheck',
      \ 'kind' : 'ftplugin',
      \ 'filetypes': { 'yaml': 1 },
      \ 'min_pattern_length' : 0,
      \ 'hooks' : {},
      \ }

function! s:kwalify_check(cmd) "{{{
    lcd `=expand('%:p:h')`
    let l:cmd = ['kwalify-check', '--complete', expand('%')] + a:cmd
    if get(g:, 'kwalify_check_debug', 0)
        echomsg "COMMAND: " . join(l:cmd, ' ')
    endif
    let l:ret = system(join(l:cmd, ' '))
    if get(g:, 'kwalify_check_debug', 0)
        echomsg "RETVAL:"
        echomsg l:ret
    endif
    lcd -
    let l:lines = split(l:ret, '\r\n\|[\r\n]')
    if empty(l:lines)
        if get(g:, 'kwalify_check_debug', 0)
            echohl ErrorMsg
            echomsg printf('kwalify-check: kwalify-check returned nothing: %s', join(l:cmd, ' '))
            echohl None
        endif
        return []
    else
        return l:lines
    endif
endfunction "}}}

function! s:push_yaml_context(context_list, item) "{{{
    let l:lst = a:context_list
    let l:indent_depth = a:item['depth']
    let l:name = a:item['name']
    while !empty(l:lst) && l:indent_depth < l:lst[-1]['depth']
        let l:lst = l:lst[:-2]
    endwhile
    if !empty(l:lst) && l:indent_depth == l:lst[-1]['depth']
        if l:lst[-1]['name'] =~# '\v^\d+$'
            let l:lst[-1]['name'] = string(l:lst[-1]['name'] + 1)
        else
            let l:lst[-1]['name'] = l:name
        endif
    else
        call add(l:lst, a:item)
    endif
    return l:lst
endfunction "}}}

function! s:get_current_context(context) "{{{
    let l:line_num = 1
    let l:current_line = line(".")
    let l:stack = []
    while l:line_num <= l:current_line
        let l:line = getline(l:line_num)
        if match(l:line, '\v^\s*#') != -1
            " Skip comments
        else
            let l:indent_depth = -1
            let l:name = ""
            let l:r = matchlist(l:line, '\v^(\s*)-')
            if !empty(l:r)
                let l:indent_depth = strlen(l:r[1])
                let l:name = "0"
                " echomsg "seq " . l:indent_depth
            else
                let l:r = matchlist(l:line, '\v^(\s*)(\S+) ?:')
                if !empty(l:r)
                    let l:indent_depth = strlen(l:r[1])
                    let l:name = l:r[2]
                    " echomsg "map " . l:indent_depth
                endif
            endif
            if 0 <= l:indent_depth
                " echomsg l:line
                let l:stack = s:push_yaml_context(l:stack, {'depth': l:indent_depth, 'name': l:name})
            endif
        endif
        let l:line_num = l:line_num + 1
    endwhile
    " let c = a:context['complete_pos'] - strlen(a:context['complete_str'])
    let c = a:context['complete_pos']
    let l:stack = s:push_yaml_context(l:stack, {'depth': c, 'name': '@'})
    let l:name_stack = []
    for i in l:stack
        call add(l:name_stack, i['name'])
    endfor
    let l:current_context = "/" . join(l:name_stack, "/")
    return l:current_context
endfunction "}}}

function! s:source.gather_candidates(context) "{{{
    let l:yaml_context = s:get_current_context(a:context)
    echomsg "CONTEXT"
    echomsg l:yaml_context
    let l:check_results = s:kwalify_check([l:yaml_context])
    let l:candidates = []
    echomsg join(l:check_results, " ")
    echomsg "RESEND"
    for l:p in l:check_results
        let l:ps = split(l:p, '\t')
        if len(l:ps) < 2
          continue
        endif
        let l:cm = l:ps[0]
        if l:cm ==# 'SNIPPET'
            if exists('g:loaded_neosnippet')
                if !exists('b:kwalify_put_neosnippet')
                    let b:kwalify_put_neosnippet = 1
                    :execute ":NeoSnippetSource " . l:ps[1]
                endif
            endif
        elseif l:cm ==# 'PREVIEW'
            if l:ps[1] ==# 'ON'
                if !exists('b:kwalify_preview_on')
                    let b:kwalify_preview_on = 1
                    setlocal completeopt+=preview
                endif
            endif
        elseif l:cm ==# 'WORD'
            if 4 <= len(l:ps)
                let l:pt = l:ps[3]
                let l:pt = substitute(l:pt, '\\n', '\n', 'g')
                call add(l:candidates, {'word': l:ps[1], 'menu': l:ps[2], 'info': l:pt})
            elseif 3 <= len(l:ps)
                call add(l:candidates, {'word': l:ps[1], 'menu': l:ps[2]})
            endif
        endif
    endfor
    return l:candidates
endfunction "}}}

function! neocomplete#sources#kwalifycheck#define()
    return s:source
endfunction

" vim: foldmethod=marker
