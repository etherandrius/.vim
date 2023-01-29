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

"
set shiftwidth=4
set tabstop=4

" Fmt
command! -nargs=0 Fmt :silent exec "!./gradlew format"


" TEST {{{
" If file is generated set it to readonly
autocmd bufenter *.java if (expand('%:h') =~ '/generated/') | set readonly | else | set noreadonly | endif
" }}}

" vim: set foldmethod=marker: set foldlevel=0
