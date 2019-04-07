set shiftwidth=2
set tabstop=2
set spell
set textwidth=80
set colorcolumn=80
set breakindent

let g:tex_indent_items = 1

" can undo individual words in insert mode
inoremap <Space> <Space><C-g>u


nnoremap <silent><leader>item o\begin{itemize}<CR><TAB>\item{<++>}<CR>\item{<++>}<CR>\end{itemize}<ESC>3k0
inoremap <silent><leader>item \begin{itemize}<CR><TAB>\item{<++>}<CR>\item{<++>}<CR>\end{itemize}<ESC>3k0

nnoremap <silent><leader>begin o\begin{<++>}<CR><TAB><++><CR>\end{<++>}<ESC>2k0
inoremap <silent><leader>begin \begin{<++>}<CR><TAB><++><CR>\end{<++>}<ESC>2k0
