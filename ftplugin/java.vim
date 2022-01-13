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

" Highlight functions
let g:limelight_mode = 'movement'
let g:limelight_bop = 'j[m0%'
let g:limelight_eop = 'k]M'

"
set shiftwidth=4
set tabstop=4

" Fmt
command! -nargs=0 Fmt :silent exec "!./gradlew format"


" TEST {{{

" If file is generated set it to readonly
autocmd bufenter *.java if (expand('%:h') =~ '/generated/') | set readonly | else | set noreadonly | endif

" colours
hi Include ctermfg=2  guifg=#859900
hi StorageClass ctermfg=2 guifg=#859900
hi Structure ctermfg=2 guifg=#859900
hi Delimiter ctermfg=10 guifg=#586e75
hi Typedef ctermfg=9 guifg=#cb4b16
" }}}

" vim: set foldmethod=marker: set foldlevel=0
