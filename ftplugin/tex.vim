set shiftwidth=2
set tabstop=2
set spell
set textwidth=80
set colorcolumn=81
set breakindent

let g:tex_indent_items = 1

" can undo individual words in insert mode
inoremap <Space> <Space><C-g>u


nnoremap <silent><leader>item o\begin{itemize}<CR>\item{<CR><++><CR>}<CR>\item{<CR><++><CR>}<CR>\end{itemize}<ESC>7k0
inoremap <silent><leader>item \begin{itemize}<CR>\item{<CR><++><CR>}<CR>\item{<CR><++><CR>}<CR>\end{itemize}<ESC>7k0

nnoremap <silent><leader>begin o\begin{<++>}<CR><++><CR>\end{<++>}<ESC>2k0
inoremap <silent><leader>begin \begin{<++>}<CR><++><CR>\end{<++>}<ESC>2k0

nnoremap <silent><leader>pbegin o\begin{<ESC>"0pa}<CR><++><CR>\end{<ESC>"0pa}<ESC>2k0
inoremap <silent><leader>pbegin \begin{<ESC>"0pa}<CR><++><CR>\end{<ESC>"0pa}<ESC>2k0

nnoremap <silent><leader>tem o\item{<CR><++><CR>}<ESC>2k0
inoremap <silent><leader>tem \item{<CR><++><CR>}<ESC>2k0



