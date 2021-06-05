" print 
nnoremap <silent> <leader>print oSystem.out.println(<++>);<Esc>FS
" inoremap <silent><leader>print System.out.println(<++>);<Esc>FS

" for loops
nnoremap <silent> <leader>for ofor(<++>;<++>;<++>){<CR><++><CR>}<CR><Esc>kkk
nnoremap <silent> <leader>ifor ofor(int i=0; i<<++>;i++) {<CR><++><CR>}<CR><Esc>kkk

" if
nnoremap <silent> <leader>if oif(<++>){<CR><++><CR>}<Esc>kk

nnoremap <silent> <leader>else oif(<++>){<CR><++><CR>} else {<Cr><++><Cr>}<Esc>kkkk

nnoremap <silent> <leader>tri a<++>? <++>: <++>;<Esc>3F<
" inoremap <silent> <leader>tri <++>? <++>: <++>;<Esc>3F<

" main
noremap <silent> <leader>main opublic static void main(String[] args){<CR><++><CR>}<Esc>kk

" class
nnoremap <silent> <leader>class opublic class <C-R>=expand("%:t:r")<CR> {<CR>}<Esc>k

" the only way in java
set foldmethod=syntax
set foldlevel=99
set foldnestmax=2

" Fold import statements
" syn clear javaInclude
syn region foldImports start=/\(^\s*\n^import\)\@<= .\+;/ end=+^\s*$+ transparent fold keepend contains=javaInclude
" syn match  javaInclude       '\v<import%(\_s+static)=>' skipwhite skipempty nextgroup=javaPackagePath

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

"
nmap gf <ESC>jV}}}}/\%V\(public\\|private\\|protected\)<CR><ESC>:noh<CR>
nmap gF <ESC>kV{{{{?\%V\(public\\|private\\|protected\)<CR><ESC>:noh<CR>


"
set shiftwidth=4
set tabstop=4


" Fmt
command! -nargs=0 Fmt :silent exec "!./gradlew format"

" colours
hi Include ctermfg=2
hi StorageClass ctermfg=2
hi Structure ctermfg=2
hi Delimiter ctermfg=10
" hi Type cterm=italic ctermfg=none
" hi Type  ctermfg=none
hi Typedef ctermfg=9

hi JavaIdentifier ctermfg=none
hi JavaAccessKeyword ctermfg=2
" hi JavaFunctionCall ctermfg=none cterm=italic

