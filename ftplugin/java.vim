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

" add = ; pair for java files
set matchpairs+==:;
