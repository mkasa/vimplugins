" autocmd BufWritePost *.hs GhcModCheckAndLintAsync
autocmd BufWritePost *.hs GhcModCheckAsync
" ghc-mod lint does not support several language extensions,
" which may annoy you with incorrect errors.
" See an example: http://trac.haskell.org/haskell-src-exts/ticket/214
