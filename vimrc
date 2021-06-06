if has('nvim')
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
endif

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

let mapleader="\<Space>"

" Statusline {{{

function! StatusZoom()
  let zoomed = zoom#statusline()
  if (zoomed == '')
    return ''
  endif
  return ' [' . zoomed . ']'
endfunction

function! StatusFugitive()
  let branch = FugitiveStatusline()
  if (branch == '')
    return ''
  endif
  return ' [' . branch[5:-3] . ']'
endfunction


" vim status line settings
set laststatus=2
set statusline=""
set statusline+=\ %m " is modified
set statusline+=%k " is modified
set statusline+=%y " Syntax
set statusline+=\ %1*[%t]%*
set statusline+=%{StatusFugitive()}
set statusline+=%{StatusZoom()}

"set statusline+=(%<%{pathshorten(expand('%:h'))})
set statusline+=\ (%<%{expand('%:h')}) " Path to file relative to PWD
set statusline+=\ %{StatusDiagnostic()}

set statusline+=%= " align to right
set statusline+=%r " is read only 
set statusline+=%q " quickfix list
set statusline+=%h " is help file
set statusline+=%w " is preview
" set statusline+=[%p%%]\ " percentage how much in file you are along
set statusline+=%l/%L,%3v\ \ \  " current line / total lines, column number

" }}}
" Vim-Plug {{{
call plug#begin()

" testing
Plug 'dhruvasagar/vim-zoom' " <C-w>m

" coding
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'} " Using this just for better syntax
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Use release branch
Plug 'liuchengxu/vista.vim' "  LSP tag viewer and finder

" qol
Plug 'tpope/vim-rhubarb' " for fugitive for enterprise github
Plug 'tpope/vim-fugitive' " essential
Plug 'djoshea/vim-autoread' " auto-reads changes to files

" search
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" visual
Plug 'mtdl9/vim-log-highlighting' " syntax for log files
Plug 'kshenoy/vim-signature' " shows marks
Plug 'scrooloose/nerdtree' " 
Plug 'osyo-manga/vim-brightest' " highlights current word in red
Plug 'rodjek/vim-puppet' " puppet syntax
Plug 'vim-scripts/MultipleSearch' " Highlight multiple words at the same time
Plug 'etherandrius/java-syntax.vim' " syntax highlight for java

" text objects
Plug 'michaeljsmith/vim-indent-object'
Plug 'wellle/targets.vim' " arguments objects - try finding an alternative
Plug 'tpope/vim-commentary' " essential

call plug#end()

" coc configuratio {{{
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
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <enter> to confirm completion
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"
" Use <TAB> to confirm completion
" inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> ge <Plug>(coc-diagnostic-next)
nmap <silent> gE <Plug>(coc-diagnostic-prev)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gl <Plug>(coc-codelens-action)

" Use K to show documentation in preview window
nnoremap <silent> gD :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use `:Fmt` to format current buffer
command! -nargs=0 Fmt :call CocAction('format')

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

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
" Outline of the document - deprecated by vista
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" auto-organize imports
" gives error *[coc.nvim] Orgnize import action not found.* including misspeled Orgnize
" autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
"
let g:coc_global_extensions = [
\ 'coc-yaml',
\ 'coc-java',
\ ]



" }}} 
" {{{ Vista

" source ~/.vim/plugged/vista.vim/autoload/vista/executive/coc.vim

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'coc'

let g:vista_blink = [0, 0]
let g:vista_top_level_blink = [0, 0]
let g:vista_keep_fzf_colors = 0
let g:vista#renderer#enable_icon = 0
let g:vista_disable_statusline = 1

nnoremap <silent> <space>o  :<C-u>Vista finder coc<cr>

" }}}
" vim-go configuration {{{

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
" disable vim-go :GoDoc shortcut (K)
let g:go_doc_keywordprg_enabled = 0

" 
let g:go_addtags_transform = 'camelcase'

" override the default goFunctionCall color, cuz it's uggo
hi def link goFunctionCall Function
let g:go_highlight_functions = 1

"
let g:go_fmt_fail_silently = 1
let g:go_fmt_autosave = 0
let g:go_doc_popup_window = 1 
let g:go_list_type_commands = {"GoImplements": "quickfix"}

let g:go_highlight_extra_types = 0
let g:go_highlight_function_parameters = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
" }}}
" {{{ MultipleSearch
" one liner for all the colours
" for i in {0..255} ; do
"     printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
"     if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
"         printf "\n";
"     fi
" done
let g:MultipleSearchColorSequence = "229,192,231,225,157,223,195"
let g:MultipleSearchTextColorSequence = "black,black,black,black,black,black,black"
let g:MultipleSearchMaxColors = 7
command! -nargs=0 Noh :noh | :SearchReset
" }}}
" {{{ NERDtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap \tt :NERDTreeToggle<cr> " tree toggle 
nnoremap \tf :NERDTreeFind<cr>   " tree find
nnoremap \tg :NERDTreeFocus<cr>  " tree go 
" }}}
" {{{ fzf
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*" --glob "!changelog" --glob "!vendor"'
let $FZF_PREVIEW_COMMAND = 'highlight -O ansi -l {} || cat {}'

nmap <leader>b :BLines<CR>
nmap <leader>t :Files<CR>
nmap <leader>T :GFiles<CR>

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --glob "!changelog" --glob "!vendor" -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

function! RipgrepFzfNoTest(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --glob "!changelog" --glob "!vendor" --glob "!*_test.go" -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nmap <leader>rg :RG!<CR>

command! -nargs=* -bang RGnotest call RipgrepFzfNoTest(<q-args>, <bang>0)

" }}}
" {{{ vim-fugitive rhubarb
let g:github_enterprise_urls = ['https://github.palantir.build']
" }}}

" {{{ netrw
    let g:netrw_altfile = 1
" }}}

" }}}

" Source {{{
source ~/.vim/spell/abbrev.vim
" }}}
" Commands Rule {{{

" *.txt fiels are filetype human
augroup filetype
  autocmd BufNewFile,BufRead *.txt set filetype=human
augroup END

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" quarter scroll
function! ScrollQ()
    let height=winheight(0)
    execute 'normal! ' . height/4 . "\<C-E>"
endfunction
nnoremap <silent> ze zz:call ScrollQ()<CR>" z eye level
vnoremap <silent> ze <C-c>zz:call ScrollQ()<CR>gv

" (aagg) Mon Oct  7 22:36:49 PDT 2019
" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" easier source, flush
if has('nvim')
command! -nargs=0 Source :source ~/.config/nvim/init.vim
else
command -nargs=0 Source :source ~/.vimrc
endif
" command! -nargs=0 Flush :NERDTreeRefreshRoot | :CommandTFlush
command! -nargs=0 Flush :NERDTreeRefreshRoot

" }}}
" Remapings {{{

nmap Q <Nop>


" (aagg) jumping to functions
nmap gf ]]<ESC>V/\%V[a-zA-Z](<CR><ESC>:noh<CR>B
nmap gF k[[<ESC>V/\%V[a-zA-Z](<CR><ESC>:noh<CR>B

" to delete a function and everything around it
nmap daf daf"_dd"_dd

" (aagg) Wed Feb 19 16:45:52 GMT 2020
nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>
" (aagg) Wed 16 Dec 2020 15:11:24 GMT
nmap <C-N> :cn<CR>zz
nmap <C-P> :cp<CR>zz

" stay in the Visual mode when using shift commands
xnoremap < <gv
xnoremap > >gv

"making C-c be identical to <Esc>
inoremap <C-c> <Esc><Esc>
nnoremap <C-c> <Esc><Esc>
vnoremap <C-c> <Esc><Esc>

"insert a line below with out entering INSERT mode.  nnoremap <C-o> o<Esc> 
" <leader>d deletes current buffer and keeps the split
nnoremap <silent> <leader>d :lclose<bar>b#<bar>bd #<CR>

" <leader>n next tab
nnoremap <silent> <leader>n :tabn<CR>  
nnoremap <silent> <leader>N :tabp<CR>  

" " <leader>n next buffer
" nnoremap <silent> <leader>n :bn<CR>  
" nnoremap <silent> <leader>N :bp<CR>  

"making shift tab work as backwards tab.
inoremap <S-Tab> <C-d>
"making tab work in visual mode.
vmap <Tab> >
vmap <S-Tab> <

" search for <++> and enter INSERT mode, careful about changing this it's used
" all over the place.
nmap <Space><Space> <Esc>h/<++><CR>:noh<CR>"_c4l

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
nnoremap K kJ
vnoremap K kJ

nnoremap ; :
vnoremap ; :

" show trailing white space and tabs
nmap <F2> :set invlist list?<CR>

" Copy to clipboard
noremap <leader>y "*y

" search for highlighted text with *
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

" }}}
" Set {{{

if &diff 
	set wrap
endif

" enables scrolling with mouse in iTerm2, a stands for all modes, use n if want normal mode scrolling only
set mouse=a

" ruby li
if !has('nvim')
    set rubydll=/usr/local/opt/ruby/lib/libruby.2.6.dylib
endif

" setting default text width
set textwidth=120

" adjusting format options to my liking
" :help fo-table for letter meanings.
set formatoptions=crqlt
set formatoptions-=o 

if has('gui')
set guifont=InputMono:h13
endif

if has('gui')
set belloff=all
endif

set foldenable

set number 
set relativenumber

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

" highlights search
set hlsearch
set incsearch

"leaves n lines between cursor and end of the screen
set scrolloff=2
set sidescrolloff=10
set sidescroll=1

"saves marks and jumps for the most recent 1000files, limits each file size to
"1000 lines.
set viminfo='1000,f1,<2000

set colorcolumn=81,101,121

" use "[RO]" for "[readonly]" to save space in the message line:
set shortmess+=r

" when using list, keep tabs at their full width and display `arrows':
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)
" (Character 187 is a right double-chevron, and 183 a mid-dot.)

set noswapfile

" keep a persistent undo file.
set undofile
set undodir=~/.vim/undo//

" eol - allows to delete end of line character with delete
" start - allows to delete all text, not just the one local to this INSERT
" mode instance.
set backspace=indent,eol,start

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

function! GetTitleString() abort
  return split(getcwd(), '/')[-1]
endfunction

" vim title settings - kinda funky care 
set titlestring=""
set titlestring+=%{GetTitleString()}\ -\ [%t]\ %M\ -\ VIM

"hi User1 cterm=bold ctermfg=230 ctermbg=241 guifg=#fdf6e3 guibg=#657b83 gui=bold
hi User1 ctermfg=230 ctermbg=241 guifg=#fdf6e3 guibg=#657b83

" better colors for matched parenthesis 
hi MatchParen gui=bold guibg=#eee8d5 guifg=#dc322f

" allow file custom settings. See bottom of this file for example
set modeline
" }}} 
" Test {{{

" (aagg) Fri 14 May 2021 00:42:12 BST
" capital P paste from buffer when in visual mode
vnoremap P "0p
nnoremap <silent> <space>p "0p
vnoremap <silent> <space>p "0p

" this does not seem to stick
inoremap jj <esc>

" Trying this out in order to use H, L, M more
nnoremap ZZ zz 

" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let ogLine = line('.')
  let ogColumn = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1

  if (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
        \ a:lowerlevel && indent(line) < indent)
    if (! a:skipblanks || strlen(getline(line)) > 0)
      if (a:exclusive)
        let line = line - stepvalue
      endif
      exe line
      exe "normal " column . "|"
      return
    endif
    endif
  endif

  " adds the current position to the jump list
  normal! m`
  call cursor(ogLine, ogColumn)

  while (line > 0 && line <= lastline) " && (indent <= indent(line) || (indent(line) == 0 && strlen(getline(line)) == 0) ))
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
noremap <silent> <C-k> :call NextIndent(0, 0, 0, 1)<CR>
noremap <silent> <C-j> :call NextIndent(0, 1, 0, 1)<CR>
vnoremap <silent> <C-k> <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> <C-j> <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''

nnoremap <C-w>n :bn<CR>
nnoremap <C-w>p :bp<CR>
nnoremap <C-w><C-c> <Nop>
nnoremap <C-w>c <Nop>
nnoremap <C-w>C <Nop>

nnoremap <leader>l <C-w>l
nnoremap <leader>L <C-w>L
nnoremap <leader>k <C-w>k
nnoremap <leader>K <C-w>K
nnoremap <leader>j <C-w>j
nnoremap <leader>J <C-w>J
nnoremap <leader>h <C-w>h
nnoremap <leader>H <C-w>H
" }}} 
" vim: set foldmethod=marker: set foldlevel=0

