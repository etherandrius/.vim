set nocompatible

set background=light
set t_Co=256
syntax on
if has("gui_running")
	let g:solarized_termcolors=256
  colorscheme solarized
  highlight Comment cterm=italic gui=italic
else
	let g:solarized_termcolors=16
  colorscheme solarized
endif
" comments in italic

if &diff 
	set wrap
endif

let g:tex_flavor = "latex"
let mapleader="\<Space>"
"nmap <Space> <leader>
"imap <Space> <leader>


" Vim-Plug {{{

call plug#begin()

Plug 'djoshea/vim-autoread'
Plug 'wincent/command-t' " fuzzy matching system 
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Use release branch
Plug 'vim-scripts/MultipleSearch'
Plug 'junegunn/limelight.vim' " 
Plug 'scrooloose/nerdtree' " need to learn this properly
Plug 'tpope/vim-commentary' " 
Plug 'vim-scripts/ZoomWin'




call plug#end()
" {{{ command-t
let g:CommandTMaxFiles=10000
" }}}
" coc configuratio {{{
lef g:go_def_mode='gopls'
lef g:go_info_mode='gopls'
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
" TODO read shortmess
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> ge <Plug>(coc-diagnostic-next)
nmap <silent> gE <Plug>(coc-diagnostic-prev)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Outline of the document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" auto-organize imports
" gives error *[coc.nvim] Orgnize import action not found.* including misspeled Orgnize
" autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" }}} 
" vim-go configuration {{{

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
" disable vim-go :GoDoc shortcut (K)
let g:go_doc_keywordprg_enabled = 0

"
let g:go_fmt_fail_silently = 1

" 
let g:go_highlight_functions = 1

let g:go_highlight_extra_types = 0
let g:go_highlight_function_parameters = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
" }}}
" {{{ MultipleSearch
let g:MultipleSearchColorSequence = "yellow,cyan,magenta,green,blue,gray,brown,red"
let g:MultipleSearchTextColorSequence = "black,black,black,black,white,white,white,white"
let g:MultipleSearchMaxColors = 8
" }}}
" {{{ limelight
nnoremap \lt :Limelight!!<cr>
" Functions
let g:limelightindent=4
function! LimeLightExtremeties()
    let limelight_start_stop='^\s\{0,'.g:limelightindent.'\}\S'
    let g:limelight_eop=limelight_start_stop
    let g:limelight_bop=limelight_start_stop
    Limelight!!
    Limelight!!
    echo 'limelightindent = '.g:limelightindent
endfunction
function! SetLimeLightIndent(count)
    let g:limelightindent = a:count
    if(g:limelightindent < 0)
        g:limelightindent = 0
    endif
    call LimeLightExtremeties()
endfunction
command! -nargs=*  SetLimeLightIndent call SetLimeLightIndent(<args>)

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1


" }}}
" {{{ NERDtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap \tt :NERDTreeToggle<cr>
nnoremap \tf :NERDTreeFind<cr>
" }}}
" {{{ netrw
    let g:netrw_altfile = 1
" }}}
" }}}
" Source {{{
source ~/.vim/spell/abbrev.vim
" }}}
" Autocmd Rule {{{

" *.txt fiels are filetype human
augroup filetype
  autocmd BufNewFile,BufRead *.txt set filetype=human
augroup END

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" }}}
" Remapings {{{

nmap Q nop

" stay in the Visual mode when using shift commands
xnoremap < <gv
xnoremap > >gv

" currently cannot map <C-S-{}> and <C-{}> to different keys :(
"nnoremap <C-S-A> <C-A>
"nnoremap <C-S-X> <C-X>

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
" nmap <leader><leader> <Esc>h/<++><CR>:noh<CR>"_c4l
" nmap <leader><Space> <Esc>h/<++><CR>:noh<CR>"_c4l
nmap <Space><Space> <Esc>h/<++><CR>:noh<CR>"_c4l
" imap <leader><Space> <C-g>u<Esc>h/<++><CR>:noh<CR>"_c4l
" imap <leader><leader> <C-g>u<Esc>h/<++><CR>:noh<CR>"_c4l

" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
nnoremap Y y$
" have U behave analogously to D and C rather than to dd and cc
nnoremap U <C-r>

" more comfortable split resizing
nnoremap <silent> + :vertical resize +3<CR>
nnoremap <silent> = :vertical resize +3<CR>
nnoremap - :vertical resize -3<CR>
nnoremap < :resize -1<CR>
nnoremap > :resize +1<CR>
" make K act analogous to J
nnoremap K k:join<CR>
vnoremap K k:join<CR>

" move to beginning/end of line.
" nnoremap B ^
" nnoremap E $

nnoremap : ;

nnoremap ; :
vnoremap ; :

" show trailing white space and tabs
" have <leader>tl ("toggle list") toggle list on/off and report the change:
nmap <F2> :set invlist list?<CR>
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



" ruby li
set rubydll=/usr/local/opt/ruby/lib/libruby.2.6.dylib

" setting default text width
set textwidth=120

" adjusting format options to my liking
" :help fo-table for letter meanings.
set formatoptions=crqlt
set formatoptions-=o

" gui foint
set guifont=InputMono:h15

" enable folding
set foldenable


" TODO figure out: I think this saves all the modifications to a file (or all
" the buffers open) and saves them in ~/.vim/view/ which are then kept
" augroup remember_folds
"     autocmd!
"     autocmd BufWinLeave * mkview
"     autocmd BufWinEnter * silent! loadview
" augroup END

" expand tab
set expandtab

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
set shiftwidth=4

" history
set history=50

" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ covert case over line breaks; also have the cursor keys
" wrap in insert mode:
set whichwrap=h,l,~,[,]

" shows the last command entered.
set showmode
set showcmd 

" lines don't wrap if the window is too small
set nowrap

" highlights the current line.
set cursorline

" shows what <C-n> can autocomplete.
set wildmenu

" options for autocomplete
set completeopt=menu,preview,noselect,menuone
set complete=.,w,b,u,t,i,kspell

" 
syntax spell notoplevel

" for performance.
set lazyredraw

" highlights search
set hlsearch
set incsearch

"leaves n lines between cursor and end of the screen
set scrolloff=2
set sidescrolloff=10
set sidescroll=1

"saves marks and jumps for the most recent 1000files, limits each file size to
"1000 lines.
set viminfo='1000,f1,<1000

set colorcolumn=81,101,121

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

" remove bell sounds from vim
set visualbell t_vb=

" add slashes to be a text object
onoremap <silent> i/ :<C-u>normal! T/vt/<CR>
onoremap <silent> a/ :<C-u>normal! F/vf/<CR>
" and for visual mode
xnoremap <silent> i/ :<C-u>normal! T/vt/<CR>
xnoremap <silent> a/ :<C-u>normal! F/vf/<CR>

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '✖ ' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, '⚠ ' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

" vim status line settings
"
set laststatus=2
set statusline=""
set statusline+=\ %m " is modified
set statusline+=%k " is modified
set statusline+=%y " Syntax
set statusline+=\ %1*[%t]%*\ 
"set statusline+=(%<%{pathshorten(expand('%:h'))})
set statusline+=(%<%{expand('%:h')})\ 

function! GetTitleString() abort
  return split(getcwd(), '/')[-1]
endfunction

" vim title settings - kinda funky care 
set titlestring=""
set titlestring+=%{GetTitleString()}\ -\ [%t]\ %M\ -\ VIM

" aagg Thu Oct 31 19:39:53 GMT 2019
" Is this useful?
"set statusline+=%{coc#status()}
set statusline+=%{StatusDiagnostic()}

set statusline+=%= " align to right
set statusline+=%r " is read only 
set statusline+=%q " quickfix list
set statusline+=%h " is help file
set statusline+=%w " is preview
" set statusline+=[%p%%]\ " percentage how much in file you are along
set statusline+=%l/%L,%3v\ \ \  " current line / total lines, column number

"hi User1 cterm=bold ctermfg=230 ctermbg=241 guifg=#fdf6e3 guibg=#657b83 gui=bold
hi User1 ctermfg=230 ctermbg=241 guifg=#fdf6e3 guibg=#657b83

" better colors for matched parenthesis 
hi MatchParen gui=bold guibg=#eee8d5 guifg=#dc322f

" allow file custom settings with 
set modeline
" }}} 
" Language servers {{{ 

"map gr :LspReferences<CR>
"map gd :LspDefinition<CR>
"map ge :LspNextError<CR>


"Python
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif



" }}}
" Test {{{

" Copy to clipboard
noremap <leader>y "*y
" Copy w command-C only works in MacVim
noremap <D-c> "*y


"
nnoremap <C-d> :keepjumps normal Lzz<CR>
nnoremap <C-u> :keepjumps normal Hzz<CR>

" (aagg) Fri Nov  8 12:55:48 GMT 2019
nnoremap <C-j> j<C-e>
nnoremap <C-k> k<C-y>

" (aagg) Wed Oct 16 15:32:16 BST 2019
map gf ]]ze
map gF [[ze

" (aagg) Mon Oct  7 22:36:49 PDT 2019
" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif


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

nnoremap :b :buffers 

" for consistency with :bd
nnoremap :tabd :tabclose
nnoremap :td :tabclose

nnoremap <C-w>n :bn<CR>
nnoremap <C-w>p :bp<CR>

nnoremap <leader>w <C-w>w
nnoremap <leader>W <C-w>W
nnoremap <leader>l <C-w>l
nnoremap <leader>L <C-w>L
nnoremap <leader>k <C-w>k
nnoremap <leader>K <C-w>K
nnoremap <leader>j <C-w>j
nnoremap <leader>J <C-w>J
nnoremap <leader>h <C-w>h
nnoremap <leader>H <C-w>H

" search and fix the next misspeled word
" THIS IS REALLY COOL BUT INTERFERS WITH PARAGRAPH JUMPING (aagg) Wed Oct 23 13:44:50 BST 2019
"nnoremap }s ]sz=1<CR>1
"nnoremap {s [sz=1<CR>1
"nnoremap zf z=1<CR>1

" for quickfix windows : when jumping to a location close the window 
autocmd Filetype qf nnoremap <CR> <CR>:ccl<CR>

" quarter scroll
function! ScrollQuarter(move)
    let height=winheight(0)

    if a:move == 'up'
        let key="\<C-Y>"
    else
        let key="\<C-E>"
    endif

    execute 'normal! ' . height/4 . key
endfunction

function! CenterFunction() 
    :keepjumps normal m9][[[`9
endfunction

" TODO FIX
function! EyeLevel()
    let height=winheight(0)
    let line=getline('.')
    let quarter=height/4
    let half=height/2
    let key="\<C-E>"

    if (line < quarter)
        return
    else 
        if (line < half) 
            execute 'normal! '. (line - quarter) . key
            return 
        else 
            execute 'normal! ' . height/4 . key
endif
    endif
return
endfunction

nnoremap <silent> <c-y> :call ScrollQuarter('up')<CR>
nnoremap <silent> <c-e> :call ScrollQuarter('down')<CR>
nnoremap <silent> ze zz:call ScrollQuarter('down')<CR>" z eye level
"nnoremap <silent> ze :call EyeLevel()<CR>" z eye level

"" DISABLED : messes with quickfix windows
" if your line is wrapped it j,k won't skip the wrapped bit.
"nnoremap j gj
"nnoremap k gk

" }}} 
" vim: set foldmethod=marker: set foldlevel=0
