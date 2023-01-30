" Not the way
" " the only way
" set foldmethod=syntax
" set foldlevel=99
" set foldnestmax=2

" The only way
set foldmethod=manual

" add = ; pair for java files
set matchpairs+==:;
set matchpairs+=<:>

" Folds are ugly and common
hi Folded ctermfg=grey
hi Folded ctermbg=white
set fillchars=fold:\ 

" vim: set foldmethod=marker: set foldlevel=0
