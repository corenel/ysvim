setlocal foldmethod=marker
setlocal expandtab
let &l:commentstring = ' ' . &commentstring

call dein#source('neosnippet.vim')
