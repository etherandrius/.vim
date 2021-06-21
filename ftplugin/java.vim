" the only way
set foldmethod=syntax
set foldlevel=99
set foldnestmax=2

" entire method
syn region javaMethod start="^\z(\s*\)\(public\|private\|protected\)\(\_[^;]\)*{\s*$" end="^\z1}\s*$" transparent fold keepend

" syn region javaLoop start="^\z(\s*\)\(for\|if\|while\|switch\).*{\s*$" end="^\z1}\s*$" transparent fold keepend
" syn region javaCase start="^\z(\s*\)\(case\|default\).*:\s*$" end="^\s*break;\s*$" transparent fold keepend
syn region javaTryCatch start="^\z(\s*\)\(try\|catch\).*{\s*$" end="^\z1}\s*$" transparent fold keepend
" syn region javadoc start="^\s*/\*\*" end="^.*\*/" transparent fold keepend
" syn region javaBlockComment start="^\s*/\*" end="^.*\*/" transparent fold keepend
"

" " This just matches {.*}. Clearing it.
" " javaFold       xxx start=/{/ end=/}/  transparent fold
" syn clear javaFold

" add = ; pair for java files
set matchpairs+==:;


" Folds are ugly and common
hi Folded ctermfg=grey
hi Folded ctermbg=white
set fillchars=fold:\ 


" Fixed paragraph jumping
nmap [[ [m
nmap ]] ]m
nmap ][ ]M
nmap [] [M

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

" Fold import statements
" doesn't work
" syn clear javaInclude
syn region foldImports start=/\(^\s*\n^import\)\@<= .\+;/ end=+^\s*$+ transparent fold keepend contains=javaInclude
" syn match  javaInclude       '\v<import%(\_s+static)=>' skipwhite skipempty nextgroup=javaPackagePath



" colours
hi Include ctermfg=2  guifg=#859900
hi StorageClass ctermfg=2 guifg=#859900
hi Structure ctermfg=2 guifg=#859900
hi Delimiter ctermfg=10 guifg=#586e75
" hi Type cterm=italic ctermfg=none
" hi Type  ctermfg=none
hi Typedef ctermfg=9 guifg=#cb4b16

hi JavaIdentifier ctermfg=none guifg=none
hi JavaAccessKeyword ctermfg=2 guifg=#859900
" hi JavaFunctionCall ctermfg=none cterm=italic

" }}}
" vim: set foldmethod=marker: set foldlevel=0
