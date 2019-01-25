filetype indent on
filetype plugin on
set nocompatible
augroup filetype
  autocmd BufNewFile,BufRead *.txt set filetype=human
augroup END

syntax on
"let g:solarized_termcolors=256
colorscheme solarized

" Vim-Plug {{{

call plug#begin()

Plug 'djoshea/vim-autoread' 
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp' " language server protocol

call plug#end()

" }}}
" Source {{{
source ~/.vim/spell/abbrev.vim
" }}}
" Remapings {{{
let mapleader="\\"
nmap <Space> <leader>
"imap <Space> <leader>

" if your line is wrapped it j,k won't skip the wrapped bit.
nnoremap j gj
nnoremap k gk

nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" currently cannot map <C-S-{}> and <C-{}> to different keys :(
"nnoremap <C-S-A> <C-A>
"nnoremap <C-S-X> <C-X>

nnoremap <C-I> ^
vnoremap <C-I> ^
nnoremap <C-a> $
vnoremap <C-a> $

" more convenient remap
map <C-q> %
" not convinced about the insert one yet
" imap <C-q> <C-o>%

"making C-c be identical to <Esc>
inoremap <C-c> <Esc><Esc>
nnoremap <C-c> <Esc><Esc>
vnoremap <C-c> <Esc><Esc>

"insert a line below with out entering INSERT mode.  nnoremap <C-o> o<Esc> 
" <leader>d deletes current buffer and keeps the split
nnoremap <silent> <leader>d :lclose<bar>b#<bar>bd #<CR>
" <leader>n next buffer
nnoremap <silent> <leader>n :bn<CR>  
nnoremap <silent> <leader>N :bp<CR>  
" <leader>p previous buffer
nnoremap <silent> <leader>p :bp<CR>
nnoremap <silent> <leader>P :bn<CR>

"making shift tab work as backwards tab.
inoremap <S-Tab> <C-d>
"making tab work in visual mode.
vmap <Tab> >
vmap <S-Tab> <


" search for <++> and enter INSERT mode, careful about changing this it's used
" all over the place.
nnoremap <leader><leader> <Esc>h/<++><CR>:noh<CR>"_c4l
inoremap <leader><leader> <C-g>u<Esc>h/<++><CR>:noh<CR>"_c4l

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$

" more comfortable split resizing
nnoremap + :vertical resize +3<CR>
nnoremap = :vertical resize +3<CR>
nnoremap - :vertical resize -3<CR>
nnoremap < :resize -1<CR>
nnoremap > :resize +1<CR>
" make K act analogous to J
nnoremap K k:join<CR>
vnoremap K k:join<CR>

" move to beginning/end of line.
nnoremap B ^
nnoremap E $

nnoremap ; :
vnoremap ; :

" show trailing white space and tabs
" have <leader>tl ("toggle list") toggle list on/off and report the change:
nnoremap <leader>tl :set invlist list?<CR>
nmap <F2> <leader>tl

" }}}
" Set {{{

" changes the cursor in vim depending on the mode (this is gnome-terminal
" specific) 
" TODO(aagg) fix this it causes visual glitches
" if has("autocmd")
"   au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
"   au InsertEnter,InsertChange *
"     \ if v:insertmode == 'i' | 
"     \   silent execute '!echo -ne "\e[6 q"' | redraw! |
"     \ elseif v:insertmode == 'r' |
"     \   silent execute '!echo -ne "\e[4 q"' | redraw! |
"     \ endif
"   au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
" endif


" adjusting format options to my liking
" :help fo-table for letter meanings.
set formatoptions=crqlt
set formatoptions-=o

" enable folding
set foldenable

" enable numbers and relative numbers
set relativenumber
set number 

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault

" expands every tab into spaces.
set expandtab

" tab length is equal to 4 spaces.
set tabstop=4

" history
set history=50

" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ covert case over line breaks; also have the cursor keys
" wrap in insert mode:
set whichwrap=h,l,~,[,]

" shows the last command entered.
set showmode
set showcmd 

" highlights the current line.
set cursorline

" shows what <TAB> can autocomplete.
set wildmenu

" for performance.
set lazyredraw

" highlights search
set hlsearch
set incsearch


"leaves 5 lines between cursor and end of the screen
set scrolloff=5

"saves marks and jumps for the most recent 100files
set viminfo='100,f1

set colorcolumn=80

" use "[RO]" for "[readonly]" to save space in the message line:
set shortmess+=r

" when using list, keep tabs at their full width and display `arrows':
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)
" (Character 187 is a right double-chevron, and 183 a mid-dot.)

" moves swap files from directory of a file to ~/.vim-tmp
set backup
set backupdir=~/.vim/swp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim/swp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" keep a persistent undo file.
set undofile
set undodir=~/.vim/undo//

" eol - allows to delete end of line character with delete
" start - allows to delete all text, not just the one local to this INSERT
" mode instance.
set backspace=indent,eol,start

" add pointy brackets <:> to be matched with %
set matchpairs+=<:>

" vim status line settings
set laststatus=2
set statusline=%F " Filename
set statusline+=\ %y " Syntax
set statusline+=%m " is modified
set statusline+=%= " align to right
set statusline+=%r " is read only 
set statusline+=%h " is help file
set statusline+=%w " is preview
" set statusline+=[%p%%]\ " percentage how much in file you are along
set statusline+=%l/%L,%3v\ \ \  " current line / total lines, column number

" allow file custom settings with 
set modeline
" }}} 
" Test {{{

"" Defining a new operator P - paste over
"" make P act like c and d
"nnoremap <silent><expr> P ':<C-u>set opfunc=PasteOver<CR>"'.v:register.'g@'
"" A function to implement paste over operator for P
"function! PasteOver(type, ...) abort
"    if a:0
"        silent exe 'norm! gv"'.v:register.'P'
"    elseif a:type is# 'line'
"        silent exe "normal! '[V']\"".v:register.'P'
"    else
"        silent exe 'normal! `[v`]"'.v:register.'P'
"    endif
"endfunction

" ]s jumps to next misspeled word, z= fixes a mispeleed word

nnoremap }s ]sz=1<CR>1
nnoremap {s [sz=1<CR>1
nnoremap zf z=1<CR>1

" }}}
" vim: set foldmethod=marker: set foldlevel=0
