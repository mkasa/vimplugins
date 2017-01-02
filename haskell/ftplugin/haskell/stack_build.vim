
setlocal makeprg=stack\ build
setlocal errorformat=%f:%l:%v:%m

"" See https://www.ishiy.xyz/posts/2015-11-29-vim-haskell.html

nnoremap <buffer> <space>: :!stack exec --
