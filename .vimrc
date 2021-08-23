" Name:     ys-vim: sensible vim and neovim configuration
" Desc:     My custom config for Vim8 and NeoVim, partly referred to ashfinal/vimrc-config, statico/dotfiles and liuchengxu/space-vim.
" Author:   corenel <xxdsox@gmail.com>
" URL:      https://github.com/corenel/ysvim
" License:  MIT license

" Use ~/.ysvim/vimrc.before if exists
if filereadable(expand("~/.ysvim/vimrc.before"))
    source $HOME/.ysvim/vimrc.before
endif

" General {{{ "

" Environment - Options, Encoding, Indent, Fold {{{

" Options {{{

" if &compatible
"     set nocompatible
" endif
set nocompatible " be iMproved, required

if !isdirectory(expand("~/.ysvim/"))
    call mkdir($HOME . "/.ysvim")
endif

set runtimepath+=$HOME/.ysvim

if has('win32')
    call mkdir($HOME . "/AppData/Local/nvim", "p")
else
    if !isdirectory($HOME . "/.config/nvim") | call mkdir($HOME . "/.config/nvim", "p") | endif
endif

" Don't set the title of the Vim window
" set notitle
set title
" Improves smoothness of redrawing
set ttyfast

" Redraw while excuting macros
" set nolazyredraw
" Don't redraw while executing macros (good performance config)
set lazyredraw

" set nojoinspaces
" set noshiftround
set noshowcmd
set nostartofline
" set nowrapscan

set belloff=all
" No annoying sound on errors
set noerrorbells
" No flashing or beeping at all
set novisualbell

set t_vb=
" using 256 colors
set t_Co=256
" put terminal in 'termcap' mode
set t_ti= t_te=
" no cursor blink
set guicursor+=a:blinkon0

" How many lines of head & tail to look for ml's
set modelines=1
" Ignore these files when tab-completing
set suffixes+=.pyc

" Configure backspace so it acts as it should act
" Allow backspace beyond insertion point
set backspace=indent,eol,start

" Use the mouse, but not in insert mode
" silent! set mouse=nvc
" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" set clipboard=unnamed,unnamedplus
" Enable clipboard if possible
if has('clipboard')
    if has('unnamedplus')
        " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else
        " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

" Terminel settings
let g:terminal_scrollback_buffer_size = 100000

" set viminfo
" let &viminfo.='100,n'.g:ysvim_home.'/files/info/viminfo'

" set ctags
set tags=./.tags;,.tags

" }}} Options

" Encoding {{{

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
set fileencodings=utf-8,chinese,taiwan,japan,korea,default,cp936,big5,latin1,ansi
set termencoding=utf-8

" Use Unix as the standard file type
set fileformats=unix,mac,dos  " Prefer Unix

set ambiwidth=double

" Also break at a multi-byte character above 255
" set formatoptions+=m
" When joining lines, don't insert a space between two multi-byte characters
" set formatoptions+=B
" Where it makes sense, remove a comment leader when joining lines
" set formatoptions+=j

" 1 - break _before_ single-letter words
set formatoptions+=1
" 2 - use indenting from 2nd line of para
" set formatoptions+=1
" Autowrap comments using textwidth
set formatoptions+=c
" Delete comment character when joining commented lines
set formatoptions+=j
" do not wrap lines that have been longer when starting insert mode already
set formatoptions+=l
" Recognize numbered lists
set formatoptions+=n
" Insert comment leader after hitting o or O in normal mode
" set formatoptions+=o
" Allow formatting of comments with "gq".
set formatoptions+=q
" Insert comment leader after hitting <Enter>
set formatoptions+=r
" Auto-wrap text using textwidth
set formatoptions+=t

set printoptions=paper:letter " US paper

set helplang& helplang=en   " Hey, if true Vim master, use English help language.


" }}} Encoding

" Indent {{{

" Carry over indenting from previous line
set autoindent
set smartindent
" Automatic program indenting
set cindent
" Comments don't fiddle with indenting
set cinkeys-=0#
" See :h cinoptions-values
set cinoptions=
" Make autoindent use the same chars as prev line
set copyindent

" Use spaces instead of tabs
set expandtab
set smarttab
" Shift to certain columns, not just n spaces
set shiftround
" Number of spaces to shift for autoindent or >,<
set shiftwidth=4
" Spaces 'feel' like tabs
set softtabstop=4
" The One True Tab
set tabstop=4
" 100 is the new 80
set textwidth=100

filetype on
filetype plugin on
filetype plugin indent on
syntax enable

" Wrap lines
set wrap
" set iskeyword+=-
set whichwrap+=<,>,h,l,[,]
set linebreak               " Break long lines by word, not char
set list

" }}} Indent

" Fold {{{

" Unicode chars for diffs/folds, and rely on colors for window borders
if has('nvim')
    set fillchars=vert:\ ,eob:\ ,
    " set fillchars=vert:\ ,eob:\ ,stl:\ ,stlnc:\ ,fold:-,diff:┄
else
    set fillchars=vert:\ ,
endif

" Use these symbols for invisible chars
set listchars=tab:¦\ ,eol:¬,trail:⋅,extends:»,precedes:«
" set listchars=tab:»\ ,eol:¬,extends:›,precedes:‹,nbsp:·,trail:·

set foldlevel=0               " Fold all by default
set foldcolumn=0
set foldnestmax=1             " maximum fold depth
silent! set foldmethod=marker " Use braces by default
set commentstring=\ \ #%s     " When folds are created, add them to this

set nofoldenable

" }}} Fold

" }}} Environment - Encoding, Indent, Fold

" Appearence - Show, Scrollbar, Color, Numberline {{{

" Scrollbar {{{

" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
" Also disable toolbar
set guioptions-=T

" }}} Scrollbar

" Highlight {{{

" Enable syntax highlighting
syntax enable

set shortmess=aoOtTI " Abbrev. of messages

" Show whitespace as special chars - see listchars
set list
" Show row/col and percentage
set ruler
" Show for lines that have been wrapped, like Emacs
set showbreak=
" Highlight matching braces/parens/etc.
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" Hightlight current line
set cursorline
" Hide mouse pointer when typing characters
set mousehide
set guicursor+=a:blinkon0   " No cursor blink
set concealcursor=niv       " Conceal neosnippet markers
set conceallevel=0

" Limit Height of the command bar
set cmdheight=1
" Show possible completions on command line
set wildmenu
" List all options and complete (http://stackoverflow.com/a/526940/5228839)
set wildmode=longest,list:full
" Ignore certain files in tab-completion
set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png            " image
set wildignore+=*.manifest                                " gb
set wildignore+=*.o,*.obj,*.exe,*.dll,*.so,*.out,*.class  " compiler
set wildignore+=*.swp,*.swo,*.swn,*.bak                   " vim
set wildignore+=*/.git,*/.hg,*/.svn                       " vcs
set wildignore+=tags,*.tags,.tags                         " tags
set wildignore+=*.pyc,*.pyo                               " Python
set wildignore+=*/.DS_Store                               " macOS
set wildignore+=node_modules                              " NodeJS
if has("win32")
    set wildignore+=*\desktop.ini
endif

set colorcolumn=79

" font setting
" if g:ysvim_linux
"     set guifont=Meslo\ LG\ M\ DZ\ for\ Powerline\ Nerd\ Font\ Complete\ 14
" endif
" if g:ysvim_macos || g:ysvim_windows
"     set guifont=MesloLGMDZ\ Nerd\ Font:h14
" endif

" }}} Highlight

" Color {{{

" Custom colors
let g:ysvim_brown = '905532'
let g:ysvim_aqua =  '3AFFDB'
let g:ysvim_blue = '689FB6'
let g:ysvim_darkBlue = '44788E'
let g:ysvim_purple = '834F79'
let g:ysvim_lightPurple = '834F79'
let g:ysvim_red = 'AE403F'
let g:ysvim_beige = 'F5C06F'
let g:ysvim_yellow = 'F09F17'
let g:ysvim_orange = 'D4843E'
let g:ysvim_darkOrange = 'F16529'
let g:ysvim_pink = 'CB6F6F'
let g:ysvim_salmon = 'EE6E73'
let g:ysvim_green = '8FAA54'
let g:ysvim_lightGreen = '31B53E'
let g:ysvim_white = 'FFFFFF'
let g:ysvim_rspec_red = 'FE405F'
let g:ysvim_git_orange = 'F54D27'

" Make sure colored syntax mode is on, and make it Just Work with 256-color terminals.
set background=dark

let g:ysvim_color = get(g:, 'ysvim_color', 'gruvbox')

" molokai color scheme
if g:ysvim_color ==# 'molokai'
    let g:rehash256 = 1 " Something to do with Molokai?
    colorscheme molokai
endif

" gruvbox color scheme
if g:ysvim_color ==# 'gruvbox'
    " enable true colors support
    set termguicolors

    " correct RGB escape codes for vim inside tmux
    if !has('nvim') && $TERM ==# 'screen-256color'
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif

    " gruvbox color scheme
    " colorscheme gruvbox
    autocmd vimenter * ++nested colorscheme gruvbox
    let g:gruvbox_contrast_dark = 'hard'
    let g:gruvbox_sign_column = 'bg0'
    " A black background would be better for remote terminal
    " due to the low FPS
    hi Normal ctermbg=none
endif

if !has('gui_running')
    if $TERM ==# 'xterm-256color' || $TERM ==# 'screen-256color' || $COLORTERM ==# 'gnome-terminal'
        set t_Co=256
    elseif has('terminfo')
        colorscheme default
        set t_Co=8
        set t_Sf=[3%p1%dm
        set t_Sb=[4%p1%dm
    else
        colorscheme default
        set t_Co=8
        set t_Sf=[3%dm
        set t_Sb=[4%dm
    endif
    " Disable Background Color Erase when within tmux - https://stackoverflow.com/q/6427650/102704
    if $TMUX !=# ''
        set t_ut=
    endif
endif

syntax on

if g:ysvim_color ==# 'molokai'
    silent! highlight Ignore ctermfg=black ctermbg=bg cterm=bold

    " Some custom spell-checking colors
    " highlight SpellBad     term=underline cterm=underline ctermbg=NONE ctermfg=205
    " highlight SpellCap     term=underline cterm=underline ctermbg=NONE ctermfg=33
    " highlight SpellRare    term=underline cterm=underline ctermbg=NONE ctermfg=217
    " highlight SpellLocal   term=underline cterm=underline ctermbg=NONE ctermfg=72

    " Custom search colors
    " highlight clear Search
    " highlight Search term=NONE cterm=NONE ctermfg=white ctermbg=black

    " Make trailing spaces very visible
    highlight SpecialKey ctermbg=Yellow guibg=Yellow

    " Make menu selections visible
    highlight PmenuSel ctermfg=black ctermbg=magenta

    " Markdown could be more fruit salady
    " highlight link markdownH1 PreProc
    " highlight link markdownH2 PreProc
    " highlight link markdownLink Character
    " highlight link markdownBold String
    " highlight link markdownItalic Statement
    " highlight link markdownCode Delimiter
    " highlight link markdownCodeBlock Delimiter
    " highlight link markdownListMarker Todo

    " Window splits & ruler are too bright, so change to white on grey (non-GUI)
    " highlight StatusLine       cterm=NONE ctermbg=blue ctermfg=white"
    " highlight StatusLineTerm   cterm=NONE ctermbg=blue ctermfg=white
    " highlight StatusLineNC     cterm=NONE ctermbg=black ctermfg=white
    " highlight StatusLineTermNC cterm=NONE ctermbg=black ctermfg=white
    " highlight VertSplit        cterm=NONE ctermbg=black ctermfg=white
endif

" set custom ignore color pattern
if g:ysvim_color ==# 'gruvbox'
    silent! highlight Ignore guifg=#928374 ctermfg=244 guibg=NONE ctermbg=NONE gui=bold cterm=bold
endif

" The Ignore color should be... ignorable
highlight clear FoldColumn
highlight def link FoldColumn Ignore
highlight clear Folded
highlight link Folded Ignore
highlight clear LineNr
highlight! def link LineNr Ignore

" Turn off horrible coloring for CDATA in XML
highlight def link xmlCdata NONE

" The sign column slows down remote terminals
highlight clear SignColumn
highlight link SignColumn Ignore

" Make hilighted matching parents less annoying
" highlight clear MatchParen
" highlight link MatchParen Search

" taglist.vim's filenames is linked to LineNr by default, which is too dark
" highlight def link MyTagListFileName Statement
" highlight def link MyTagListTagName Question

" }}} Color

" Linenumber {{{

" Show linenumber by default
if !exists('g:noshowlinenumber')
    set number relativenumber
else
    set nonumber norelativenumber
endif

" Use absolute linenum in Insert mode; relative linenum in Normal mode
augroup number:
    autocmd!
    autocmd FocusLost,InsertEnter * :call UseAbsNum()
    autocmd FocusGained,InsertLeave * :call UseRelNum()
augroup END

function! UseAbsNum()
    if exists('g:noshowlinenumber') || exists('#goyo')
        set nonumber norelativenumber
    else
        set number norelativenumber
    endif
endfunction

function! UseRelNum()
    if exists('g:noshowlinenumber') || exists('#goyo')
        set nonumber norelativenumber
    else
        set number relativenumber
    endif
endfunction

" }}} Linenumber

" }}} Appearence - Scrollbar, Color, Numberline

" Edit - Navigation, History, Search {{{

" Navigation {{{

" Make cursor always on center of screen by default
if !exists('g:rc_always_center')
    let g:rc_always_center = 1
else
    if g:rc_always_center == 0 | augroup! rc_always_center | endif
endif

augroup rc_always_center
    autocmd!
    autocmd VimEnter,WinEnter,VimResized * call RCAlwaysCenterOrNot()
augroup END

function! RCAlwaysCenterOrNot()
    if g:rc_always_center
        " Use <Enter> to keep center in insert mode, need proper scrolloff
        let &scrolloff = float2nr(floor(winheight(0) / 2) + 1)
        inoremap <CR> <CR><C-o>zz
    else
        let &scrolloff = 0
        silent! iunmap <CR>
    endif
endfunction

set scroll=4                " Number of lines to scroll with ^U/^D
set scrolloff=15            " Keep cursor away from this many chars top/bot
set sidescrolloff=3         " Keep cursor away from this many chars left/right

" set virtualedit=onemore
set virtualedit=block

" How many lines to scroll at a time, make scrolling appears faster
" set scrolljump=3

" Don't restore all options and mappings
set sessionoptions-=options

" Restore last session automatically (default off)
if !exists('g:rc_restore_last_session') | let g:rc_restore_last_session = 0 | endif

" Always save the last session
augroup rc_save_session
    autocmd!
    autocmd VimLeave * exe ":mksession! ~/.ysvim/.last.session"
augroup END

" Try to restore last session
augroup rc_restore_session
    autocmd!
    autocmd VimEnter * call RCRestoreLastSession()
augroup END

function! RCRestoreLastSession()
    if g:rc_restore_last_session
        if filereadable(expand("~/.ysvim/.last.session"))
           exe ":source ~/.ysvim/.last.session"
       endif
   endif
endfunction

" Restore the last session manually
if filereadable(expand("~/.ysvim/.last.session"))
    nnoremap <silent> <Leader>r :source ~/.ysvim/.last.session<CR>
endif

" set complete=.  " default: .,w,b,u,t
" set completeopt=menu,noinsert,noselect
set completeopt=menu,preview,longest

set previewheight=15
" set pumheight=25
set pumheight=10

" Automatically close the preview window when popup menu is invisible
if !exists('g:rc_auto_close_pw')
    let g:rc_auto_close_pw = 1
else
    if g:rc_auto_close_pw == 0 | augroup! rc_close_pw | end
endif

augroup rc_close_pw
    autocmd!
    autocmd CursorMovedI,InsertLeave * call RCClosePWOrNot()
augroup END

function! RCClosePWOrNot()
    if g:rc_auto_close_pw
        if !pumvisible() && (!exists('*getcmdwintype') || empty(getcmdwintype()))
            silent! pclose
        endif
    endif
endfunction

" }}} Navigation

" History {{{

set viewoptions=folds,cursor,unix,slash " Better Unix / Windows compatibility

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

" Visually select the text that was last edited/pasted
nnoremap <expr> gV '`[' . strpart(getregtype(), 0, 1) . '`]'

" Set to auto read when a file is changed from the outside
set autoread
" Automatically write a file when leaving a modified buffer
set autowrite
set updatetime=200

" Set how many lines of history VIM has to remember
set history=1000
set undoreload=1000

" Turn backup off, since most stuff is in SVN, git etc anyway...
set directory-=.            " Don't store temp files in cwd
set nobackup
set nowritebackup

set noswapfile
set shortmess+=A            " Don't bother me when a swapfile exists
set sessionoptions-=options " Don't save runtimepath in Vim session (see tpope/vim-pathogen docs)

" Swap files are necessary when crash recovery
" if !isdirectory($HOME . "/.ysvim/swapfiles") | call mkdir($HOME . "/.ysvim/swapfiles", "p") | endif
" set dir=$HOME/.ysvim/swapfiles//

" Turn persistent undo on, means that you can undo even when you close a buffer/VIM
set undofile
set undolevels=1000

if !isdirectory($HOME. "/.ysvim/undotree") | call mkdir($HOME . "/.ysvim/undotree", "p") | endif
set undodir=$HOME/.ysvim/undotree//

" }}} History

" Search {{{

" For regular expressions turn magic on
set magic
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" Don't wrap around when jumping between search result
" set nowrapscan
"
set inccommand=nosplit
set infercase               " Completion recognizes capitalization
set matchtime=2             " Tenths of second to highlight matching partten
set maxmempattern=2000000

" set regexpengine=2

" Disable highlight when <Enter> is pressed
nnoremap <silent> <BS> :nohlsearch<CR>

" }}} Search

" }}} Edit - Navigation, History, Search

" Buffer - BufferSwitch, FileExplorer, StatusLine {{{

" A buffer becomes hidden when it is abandoned
" Don't prompt to save hidden windows until exit
set hidden
" Don't change current working directory automatically
" set noautochdir
" change current working directory automatically
set autochdir

" BufferSwitch {{{

" Specify the behavior when switching between buffers
set switchbuf=useopen
set showtabline=1

" }}} BufferSwitch

" FileExplorer {{{

let g:netrw_liststyle = 3
let g:netrw_winsize = 30
nnoremap <silent> <Leader>e :Vexplore <C-r>=expand("%:p:h")<CR><CR>
autocmd FileType netrw setlocal bufhidden=delete

" Puts new vsplit windows to the right of the current
set splitright
" Puts new split windows to the bottom of the current
set splitbelow

" Split management
nnoremap <silent> [b :bprevious<cr>
nnoremap <silent> ]b :bnext<cr>
nnoremap <silent> <C-k> :resize +2<CR>
nnoremap <silent> <C-j> :resize -2<CR>
nnoremap <silent> <C-h> :vertical resize +4<CR>
nnoremap <silent> <C-l> :vertical resize -4<CR>

" }}} FileExplorer

" StatusLine {{{

" Always show status line
set laststatus=2
set statusline=%<%f                        " filename
set statusline+=\ %w%h%m%r                 " option
set statusline+=\ [%{&ff}]/%y              " fileformat/filetype
set statusline+=\ [%{getcwd()}]            " current dir
set statusline+=\ [%{&encoding}]           " encoding
set statusline+=%=%-14.(%l/%L,%c%V%)\ %p%% " Right aligned file nav info

" }}} StatusLine

" }}} Buffer - BufferSwitch, FileExplorer, StatusLine

" Key Mappings {{{

" Map ; to : and save a million keystrokes
nnoremap ; :

" With a map leader it's possible to do extra key combinations
let mapleader = "\<Space>"

" Useful macros I use the most
" nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
" nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
" nmap \b :set nocin tw=80<CR>:set formatoptions+=a<CR>
" nmap \c :call TmuxPaneClear()<CR>
" nmap \l :setlocal number!<CR>:setlocal number?<CR>
" nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
" nmap \r :call TmuxPaneRepeat()<CR>
" nmap \s :setlocal invspell<CR>
" nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
" nmap \u :setlocal list!<CR>:setlocal list?<CR>
" nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>
" nmap \A :set formatoptions+=a<CR>:echo 'autowrap enabled'<CR>
" nmap \a :set formatoptions-=a<CR>:echo 'autowrap disabled'<CR>
nmap \c :CLEAN<CR>:TEOL<CR>
nmap \e :Vaffle<CR>
nmap \f :Neoformat<CR>
nmap \g :Gstatus<CR>
nmap \h :nohlsearch<CR>
nmap \i vip:sort<CR>
nmap \l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=2 concealcursor=niv"<CR>
nmap \o :set paste!<CR>:set paste?<CR>
nmap \v :Startify<CR>
nmap \x :cclose<CR>
nmap \t :tabnew<CR>
vnoremap \y :OSCYank<CR>
nmap \y <Plug>OSCYank
nmap \z :w<CR>:!open %<CR><CR>

" Map BS to \ for HHKB layout
" nnoremap <BS> \
nmap <BS>c \c
nmap <BS>e \e
nmap <BS>f \f
nmap <BS>g \g
nmap <BS>h \h
nmap <BS>i \i
nmap <BS>l \l
nmap <BS>o \o
nmap <BS>t \t
nmap <BS>v \v
nmap <BS>x \x
nmap <BS>z \z

" Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with
" line wrapping on, this can cause the cursor to actually skip a few lines on the screen because
" it's moving from line N to line N+1 in the file. I want this to act more visually -- I want `down'
" to mean the next line on the screen
" nmap j gj
" nmap k gk
nmap j <Plug>(accelerated_jk_gj_position)
nmap k <Plug>(accelerated_jk_gk_position)

" Marks should go to the column, not just the line. Why isn't this the default?
nnoremap ' `

" Map jk to enter normal mode
imap jk <Esc>

" You don't know what you're missing if you don't use this.
nmap <C-e> :e#<CR>

" Move between open buffers.
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" Move between open tabs.
nmap <C-f> :tabnext<CR>
nmap <C-b> :tabprev<CR>

" Add new line without entering insert mode
nmap <S-CR> O<Esc>
nmap <CR> o<Esc>

" Emacs-like bindings in insert mode
imap <C-e> <C-o>$
imap <C-a> <C-o>0

" Emacs-like bindings in the command line from `:h emacs-keys`
cnoremap <C-a>  <Home>

" Ctrl-[hl]: Move left/right by word
cnoremap <C-h> <S-Left>
cnoremap <C-l> <S-Right>

" Ctrl-[bf]: I don't use <C-b> to open mini window often
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>

cnoremap <C-d>  <Del>
cnoremap <C-e>  <End>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>

" Use the space key to toggle folds
nnoremap <space> za
vnoremap <space> zf

" Ctrl-a: Go to begin of line
inoremap <C-a> <Home>

" Ctrl-e: Go to end of line
inoremap <C-e> <End>

" Ctrl-[bf]: Move cursor left/right
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" Ctrl-[hl]: Move left/right by word
inoremap <C-h> <S-Left>
inoremap <C-l> <S-Right>

" Ctrl-[kj]: Move cursor up/down
inoremap <C-k> <C-o>gk
inoremap <C-j> <C-o>gj

" Recover from accidental Ctrl-U http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Ctrl-[kj]: Move lines up/down
" replaced by vim-textmanip plugin
" vnoremap <silent> <C-j> :m '>+1<CR>gv=gv
" vnoremap <silent> <C-k> :m '<-2<CR>gv=gv

" Search for the word under the cursor in the current directory
nmap <M-k>    mo:Ack! "\b<cword>\b" <CR>
nmap <Esc>k   mo:Ack! "\b<cword>\b" <CR>
nmap <M-S-k>  mo:Ggrep! "\b<cword>\b" <CR>
nmap <Esc>K   mo:Ggrep! "\b<cword>\b" <CR>

" Alt-W to delete a buffer and remove it from the list but keep the window via bufkill.vim
nmap <Esc>w :BD<CR>
nmap <M-w>  :BD<CR>
nmap ∑      :BD<CR>

" Fix annoyances in the QuickFix window, like scrolling too much
augroup quickfix
    autocmd!
    autocmd FileType qf setlocal number nolist scrolloff=0
    autocmd Filetype qf wincmd J " Makes sure it's at the bottom of the vim window
augroup END

" Commands to send common keystrokes using tmux
" let g:tmux_console_pane = '0:0.0'
" let g:tmux_server_pane = '0:0.0'
" function TmuxPaneRepeat()
"     write
"     silent execute ':!tmux send-keys -t' g:tmux_console_pane 'C-p' 'C-j'
"     redraw!
" endfunction
" function TmuxPaneClear()
"     silent execute ':!tmux send-keys -t' g:tmux_server_pane 'C-j' 'C-j' 'C-j' 'C-j' 'C-j' 'C-j' 'C-j'
"     redraw!
" endfunction

" Make the cursor stay on the same line when window switching
function! KeepCurrentLine(motion)
    let l:theLine = line('.')
    let l:theCol = col('.')
    exec 'wincmd ' . a:motion
    if &diff
        call cursor(l:theLine, l:theCol)
    endif
endfunction
nnoremap <C-w>h :silent call KeepCurrentLine('h')<CR>
nnoremap <C-w>l :silent call KeepCurrentLine('l')<CR>

" Typing `$c` on the command line expands to `:e` + the current path, so it's easy to edit a file in
" the same directory as the current file.
cnoremap $c e <C-\>eCurrentFileDir()<CR>
function! CurrentFileDir()
    return 'e ' . expand('%:p:h') . '/'
endfunction

" }}} Key Mappings

" Misc {{{

" Custom commands and functions {{{

" GlobalAutoCmd:
augroup GlobalAutoCmd
    autocmd!
augroup END
command! -nargs=* Gautocmd   autocmd GlobalAutoCmd <args>
command! -nargs=* Gautocmdft autocmd GlobalAutoCmd FileType <args>

" Global:
Gautocmd BufWinEnter *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'gitcommit' |
        \ execute "silent! keepjumps normal! g`\"zz"

" Vim:
" nested autoload
" Gautocmd BufWritePost $MYVIMRC,*.vim nested silent! source $MYVIMRC | setlocal colorcolumn=99

" Sh:
Gautocmdft sh let g:sh_noisk=1
" Gautocmd BufWritePre *.sh\|bash Neomake

" Markdown:
Gautocmdft markdown let g:sh_noisk=1

" Neosnippet:
" Gautocmdft neosnippet call dein#source('neosnippet.vim')
" Clear neosnippet markers when InsertLeave
" Gautocmd InsertLeave * NeoSnippetClearMarkers

" Gitcommit:
Gautocmd BufEnter COMMIT_EDITMSG startinsert
" Gautocmdft gina-commit startinsert

" Trim spaces at EOL and retab. I run `:CLEAN` a lot to clean up files.
command! TEOL %s/\s\+$//
command! CLEAN retab | TEOL

" Close all buffers except this one
command! BufCloseOthers %bd|e#

" Exit if the last window is a controlling one (NERDTree, qf).
function! s:CloseIfOnlyControlWinLeft()
    if winnr('$') != 1
        return
    endif
    " Alt Source: https://github.com/scrooloose/nerdtree/issues/21#issuecomment-3348390
    " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
            \ || &buftype ==? 'quickfix'
        " NOTE: problematic with Unite's directory, when opening a file:
        " :Unite from startify, then quitting Unite quits Vim; also with TMRU from
        " startify.
            " \ || &ft == 'startify'
        q
    endif
endfunction
augroup CloseIfOnlyControlWinLeft
    autocmd!
    autocmd BufEnter * call s:CloseIfOnlyControlWinLeft()
augroup END

" macOS Frameworks and system header protection
Gautocmd BufNewFile,BufReadPost
        \ /System/Library/*,/Applications/Xcode*,/usr/include*,/usr/lib*
        \ setlocal readonly nomodified

" Quickfix:
" http://vim.wikia.com/wiki/Automatically_fitting_a_quickfix_window_height
function! AdjustWindowHeight(minheight, maxheight)
    let s:l = 1
    let s:n_lines = 0
    let s:w_width = winwidth(0)
    while s:l <= line('$')
    " number to float for division
    let s:l_len = strlen(getline(s:l)) + 0.0
    let s:line_width = s:l_len/s:w_width
    let s:n_lines += float2nr(ceil(s:line_width))
    let s:l += 1
    endw
    exe max([min([s:n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction
Gautocmdft qf call AdjustWindowHeight(5, 10)

function! ToggleVaffle()
    if exists("t:explorer_buf_num")
        let l:explorer_win_num = bufwinnr(t:explorer_buf_num)
        if l:explorer_win_num != -1
            let l:cur_win_num = winnr()
            exec l:explorer_win_num . 'wincmd w'
            close
            exec l:cur_win_num . 'wincmd w'
            unlet t:explorer_buf_num
        else
            unlet t:explorer_buf_num
        endif
    else
        exec 'wincmd v'
        exec '1wincmd w'
        Vaffle
        vertical resize 32
        let t:explorer_buf_num = bufnr('%')
    endif
endfunction

" }}} Custom commands and functions

" Other {{{

" Toggle tmux statusline automatically
" if exists('$TMUX')
"     augroup tmuxstatusbar:
"         autocmd!
"         autocmd VimEnter,VimLeave * :silent !tmux set status
"     augroup END
" endif

" Define how to use the CTRL-A and CTRL-X commands for adding to and subtracting from a number respectively
set nrformats=alpha,octal,hex

" For when you forget to sudo... Really write the file.
if !has('win32')
    command! W w !sudo tee % > /dev/null
endif

augroup rc_warning_highlight
    autocmd!
    autocmd ColorScheme * call matchadd('Todo', '\W\zs\(NOTICE\|WARNING\|DANGER\)')
augroup END

" Find out to which highlight-group a particular keyword/symbol belongs
command! Wcolor echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") .
            \ "> trans<" . synIDattr(synID(line("."),col("."),0),"name") .
            \ "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") .
            \ "> fg:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")

augroup rc_ft_settings
    autocmd!
    autocmd FileType python setlocal foldmethod=indent textwidth=80
    autocmd BufNewFile,BufRead *.org setlocal filetype=org commentstring=#%s
    autocmd BufNewFile,BufRead *.tex setlocal filetype=tex
    autocmd FileType qf setlocal nowrap
augroup END

" Strip trailing spaces and blank lines of EOF when saving files
if !exists('g:rc_strip_wsbl')
    let g:rc_strip_wsbl = 1
else
    if g:rc_strip_wsbl == 0 | augroup! rc_strip_wsbl | endif
endif

augroup rc_strip_wsbl
    autocmd!
    autocmd BufWritePre * if &modifiable && &modified | call RCStripWSBL() | endif
augroup END

nnoremap <silent> <Leader>s :call RCStripWSBL()<CR>
function! RCStripWSBL()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//ge
    %s/\(\n\)\+\%$//ge
    call cursor(l, c)
endfunction

" Make TOhtml behavior better
let g:html_dynamic_folds = 1
let g:html_prevent_copy = "fntd"

if has("patch-8.2.766") || has("nvim-0.3.5")
    set diffopt+=vertical
    set diffopt+=algorithm:histogram
    set diffopt+=indent-heuristic
endif

" }}} Other

" }}} Misc

" }}} General "

" Plugins List & Config {{{ "

" Plugin List {{{ "
" Use plug.vim by default
if !exists('g:rc_use_plug_manager') | let g:rc_use_plug_manager = 1 | endif
if g:rc_use_plug_manager
    if filereadable(expand("~/.ysvim/autoload/plug.vim"))
        call plug#begin('~/.ysvim/plugged')

        Plug 'bling/vim-airline'
        if version >= 704 || version ==703 && has('patch005')
            Plug 'mbbill/undotree'
        endif
        Plug 'mattn/emmet-vim'
        Plug 'dhruvasagar/vim-table-mode'
        Plug 'machakann/vim-sandwich'
        Plug 'wellle/targets.vim'
        Plug 'kshenoy/vim-signature'
        Plug 'scrooloose/nerdcommenter'
        Plug 'Raimondi/delimitMate'
        if version >= 704 && has('python3')
            Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
        endif
        Plug 'junegunn/vim-easy-align'
        Plug 'junegunn/goyo.vim'
        Plug 'junegunn/limelight.vim'
        Plug 'ctrlpvim/ctrlp.vim'
        if version >= 704
            Plug 'tpope/vim-fugitive'
        endif
        if version >= 800 || has('nvim')
            Plug 'skywind3000/asyncrun.vim'
            Plug 'mg979/vim-visual-multi'
        endif
        Plug 't9md/vim-textmanip'
        if executable('ctags')
            Plug 'preservim/tagbar'
        endif
        if executable('latexmk')
            Plug 'lervag/vimtex'
        endif
        if !has('win32')
            Plug 'metakirby5/codi.vim'
        endif
        Plug 'ashfinal/vim-one'
        if version >= 800 || has('nvim')
            Plug 'neoclide/coc.nvim', {'branch': 'release'}
        else
            if version >= 703 && has('lua')
                Plug 'Shougo/neocomplete.vim'
            endif
        endif

        Plug 'mhinz/vim-startify'
        Plug 'morhetz/gruvbox'
        Plug 'cocopon/vaffle.vim'

        Plug 'kana/vim-operator-user'
        Plug 'kana/vim-textobj-function'
        Plug 'kana/vim-textobj-user'
        Plug 'kana/vim-textobj-indent'
        Plug 'sgur/vim-textobj-parameter'
        Plug 'kana/vim-operator-replace'
        Plug 'rhysd/vim-operator-surround'
        Plug 'tpope/vim-unimpaired'
        Plug 'haya14busa/vim-asterisk'
        Plug 'tpope/vim-commentary'
        Plug 'tpope/vim-repeat'
        Plug 'tpope/vim-surround'
        Plug 'tpope/vim-obsession'
        Plug 'rhysd/accelerated-jk'

        Plug 'christoomey/vim-tmux-navigator'
        Plug 'roxma/vim-tmux-clipboard'
        Plug 'tmux-plugins/vim-tmux-focus-events'
        Plug 'tmux-plugins/vim-tmux'
        Plug 'ojroques/vim-oscyank'

        Plug 'w0rp/ale'
        Plug 'sbdchd/neoformat'
        Plug 'mtdl9/vim-log-highlighting'
        Plug 'chrisbra/vim-sh-indent'

        Plug 'wakatime/vim-wakatime'

        if filereadable(expand("~/.ysvim/vimrc.plug"))
            source $HOME/.ysvim/vimrc.plug
        endif
        call plug#end()
    else
        if executable('git')
            call mkdir($HOME . "/.ysvim/autoload", "p")
            if has('python')
                echo "Downloading plug.vim, please wait a second..."
                exe 'py import os,urllib2; f = urllib2.urlopen("https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"); g = os.path.join(os.path.expanduser("~"), ".ysvim/autoload/plug.vim"); open(g, "wb").write(f.read())'
            else
                if has('python3')
                    echo "Downloading plug.vim, please wait a second..."
                    exe 'py3 import os,urllib.request; f = urllib.request.urlopen("https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"); g = os.path.join(os.path.expanduser("~"), ".ysvim/autoload/plug.vim"); open(g, "wb").write(f.read())'
                else
                    redir >> ~/.ysvim/vimrc.before | echom 'let g:rc_use_plug_manager = 0' | redir END
                    echo "WARNING: plug.vim has been disabled due to the absence of 'python' or 'python3' features.\nIf you solve the problem and want to use it, you should delete the 'let g:rc_use_plug_manager = 0' line in '~/.ysvim/vimrc.before' file.\nIf you don't take any action, that's OK. This message won't appear again. If you have any trouble please file an issue."
                endif
            endif
            if filereadable(expand("~/.ysvim/autoload/plug.vim"))
                echo "PluginManager - plug.vim just installed! vim will quit now.\nYou should relaunch vim, use PlugInstall to install plugins OR do nothing just use the basic config."
                exe 'qall!'
            endif
        else
            redir >> ~/.ysvim/vimrc.before | echom 'let g:rc_use_plug_manager = 0' | redir END
            echo "WARNING: plug.vim has been disabled due to the absence of 'git'.\nIf you solve the problem and want to use it, you should delete the 'let g:rc_use_plug_manager = 0' line in '~/.ysvim/vimrc.before' file.\nIf you don't take any action, that's OK. This message won't appear again. If you have any trouble please file an issue."
        endif
    endif
endif

" }}} Plugin List "

" Plugin Config {{{ "

if g:rc_use_plug_manager && filereadable(expand("~/.ysvim/autoload/plug.vim"))

    " Plugin Config - onecolorscheme {{{ "

    if filereadable(expand("~/.ysvim/plugged/vim-one/colors/one.vim"))
        colorscheme one
        if has("gui_running") || has("gui_vimr")
            set background=light
        endif
    endif

    " }}} Plugin Config - onecolorscheme "

    " Plugin Config - undotree {{{ "

    if filereadable(expand("~/.vim/plugged/undotree/plugin/undotree.vim"))
        let g:undotree_SplitWidth = 40
        let g:undotree_SetFocusWhenToggle = 1
        nnoremap <silent> <Leader>u :UndotreeToggle<CR>
    endif

    " }}} Plugin Config - undotree "

    " Plugin Config - ultisnips {{{ "

    if filereadable(expand("~/.ysvim/plugged/ultisnips/plugin/UltiSnips.vim"))
        let g:UltiSnipsExpandTrigger = "<Tab>"
        let g:UltiSnipsJumpForwardTrigger = "<Tab>"
        let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
        let g:UltiSnipsEditSplit = "context"
        if !isdirectory($HOME . "/.ysvim/UltiSnips") | call mkdir($HOME . "/.ysvim/UltiSnips", "p") | endif
        let g:UltiSnipsSnippetsDir = "~/.ysvim/UltiSnips"
    endif

    " }}} Plugin Config - ultisnips "

    " Plugin Config - emmet-vim {{{ "

    if filereadable(expand("~/.ysvim/plugged/emmet-vim/plugin/emmet.vim"))
        let g:user_emmet_install_global = 0
        autocmd FileType html,xhtml,xml,css,scss,sass,less EmmetInstall
        let g:user_emmet_leader_key = ','
    endif

    " }}} Plugin Config - emmet-vim "

    " Plugin Config - vim-table-mode {{{ "

    if filereadable(expand("~/.ysvim/plugged/vim-table-mode/autoload/tablemode.vim"))

        let g:table_mode_auto_align = 0
        autocmd FileType markdown,rst,org :silent TableModeEnable

        autocmd FileType markdown
                    \ let g:table_mode_corner = "|" |
                    \ let g:table_mode_corner_corner = "|" |
                    \ let g:table_mode_header_fillchar = "-" |
                    \ let g:table_mode_align_char = ":"
        autocmd FileType rst
                    \ let g:table_mode_corner = "+" |
                    \ let g:table_mode_corner_corner = "+" |
                    \ let g:table_mode_header_fillchar = "="
        autocmd FileType org
                    \ let g:table_mode_corner = "+" |
                    \ let g:table_mode_corner_corner = "|" |
                    \ let g:table_mode_header_fillchar = "-"
    endif

    " }}} Plugin Config - vim-table-mode "

    " Plugin Config - vim-textmanip {{{ "

    if filereadable(expand("~/.ysvim/plugged/vim-textmanip/autoload/textmanip.vim"))

        xmap <C-j> <Plug>(textmanip-move-down)
        xmap <C-k> <Plug>(textmanip-move-up)
        xmap <C-h> <Plug>(textmanip-move-left)
        xmap <C-l> <Plug>(textmanip-move-right)

    endif

    " }}} Plugin Config - vim-textmanip "

    " Plugin Config - neocomplete {{{ "

    if filereadable(expand("~/.ysvim/plugged/neocomplete.vim/plugin/neocomplete.vim"))
        let g:neocomplete#enable_at_startup = 1
    else
        set omnifunc=syntaxcomplete#Complete
    endif

    " }}} Plugin Config - neocomplete "

    " Plugin Config - nerdcommenter {{{ "

    if filereadable(expand("~/.ysvim/plugged/nerdcommenter/plugin/NERD_commenter.vim"))
        " Always leave a space between the comment character and the comment
        let NERDSpaceDelims = 1
        map <Bslash> <plug>NERDCommenterInvert
        vmap <C-Bslash> <plug>NERDCommenterSexy
    endif

    " }}} Plugin Config - nerdcommenter "

    " Plugin Config - Goyo {{{ "

    if filereadable(expand("~/.ysvim/plugged/goyo.vim/plugin/goyo.vim"))
        nmap <silent> <C-w><Space> :Goyo<CR>
        function! s:goyo_enter()
            let b:fcstatus = &foldcolumn
            setlocal foldcolumn=0
        endfunction

        function! s:goyo_leave()
            let &foldcolumn = b:fcstatus
        endfunction

        autocmd! User GoyoEnter nested call <SID>goyo_enter()
        autocmd! User GoyoLeave nested call <SID>goyo_leave()
    endif

    " }}} Plugin Config - Goyo "

    " Plugin Config - Limelight {{{ "

    if filereadable(expand("~/.ysvim/plugged/limelight.vim/plugin/limelight.vim"))
        nmap <silent> <C-w><Enter> :Limelight!!<CR>
        let g:limelight_conceal_ctermfg = 250
        let g:limelight_default_coefficient = 0.8
    endif

    " }}} Plugin Config - Limelight "

    " Plugin Config - CtrlP {{{ "

    if filereadable(expand("~/.ysvim/plugged/ctrlp.vim/plugin/ctrlp.vim"))
        if executable('rg')
            let g:ctrlp_user_command = 'rg %s --files --no-hidden --color=never --glob ""'
        endif
        let g:ctrlp_map = '<Leader>o'
        let g:ctrlp_cmd = 'CtrlPBuffer'
        let g:ctrlp_mruf_exclude = '/tmp/.*\|\.w3m/.*\|/var/folders/.*'

        augroup rc_mru_cleanup
            autocmd!
            autocmd VimEnter * call ctrlp#mrufiles#refresh()
        augroup end
    endif

    " }}} Plugin Config - CtrlP "

    " Plugin Config - vim-easy-align {{{ "

    if filereadable(expand("~/.ysvim/plugged/vim-easy-align/plugin/easy_align.vim"))
        map <Leader>g :EasyAlign<Space>
        xmap ga <Plug>(EasyAlign)
        nmap ga <Plug>(EasyAlign)
    endif

    " }}} Plugin Config - vim-easy-align "

    " Plugin Config - airline {{{ "

    if filereadable(expand("~/.ysvim/plugged/vim-airline/plugin/airline.vim"))
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#buffer_nr_show = 1
        let g:airline#extensions#tabline#fnamemod = ':t'
        " Automatically show/hide invisible characters depend on file is dirty or nor
        augroup rc_listmode_dirtyfile
            autocmd!
            autocmd BufReadPost * if airline#extensions#whitespace#check()!="" | setl list | endif
        augroup END
    endif

    " }}} Plugin Config - airline "

    " Plugin Config - vimtex {{{ "

    if filereadable(expand("~/.ysvim/plugged/vimtex/autoload/vimtex.vim"))
        let g:vimtex_compiler_latexmk = {
            \ 'options' : [
            \   '-xelatex',
            \   '-shell-escape',
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \ ],
            \}
        " vimtex configuration for neocomplete
        if exists('g:loaded_neocomplete')
            if !exists('g:neocomplete#sources#omni#input_patterns')
                let g:neocomplete#sources#omni#input_patterns = {}
            endif
            let g:neocomplete#sources#omni#input_patterns.tex =
                \ g:vimtex#re#neocomplete
        endif
    endif

    " }}} Plugin Config - vimtex "

    " Plugin Config - visual-multi {{{ "

    let g:VM_mouse_mappings   = 1
    let g:VM_skip_empty_lines = 1
    let g:VM_silent_exit      = 1

    function! VM_Start()
        if exists(":DelimitMateOff") | exe 'DelimitMateOff' | endif
    endfunction

    function! VM_Exit()
        if exists(':DelimitMateOn') | exe 'DelimitMateOn' | endif
    endfunction

    let g:VM_leader = {'default': '<Leader>', 'visual': '<Leader>', 'buffer': 'z'}
    let g:VM_maps                           = {}
    let g:VM_maps["Get Operator"]           = '<Leader>a'
    let g:VM_maps["Add Cursor At Pos"]      = '<Leader><Space>'
    let g:VM_maps["Reselect Last"]          = '<Leader>z'
    let g:VM_maps["Visual Cursors"]         = '<Leader><Space>'
    let g:VM_maps["Undo"]                   = 'u'
    let g:VM_maps["Redo"]                   = '<C-r>'
    let g:VM_maps["Visual Subtract"]        = 'zs'
    let g:VM_maps["Visual Reduce"]          = 'zr'

    " }}} Plugin Config - visual-multi "

    " Plugin Config - coc.nvim {{{ "

    if filereadable(expand("~/.ysvim/plugged/coc.nvim/plugin/coc.vim"))
        " Remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gl <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)
        nmap <silent> g= <Plug>(coc-format)
        vmap <silent> g= <Plug>(coc-format-selected)
        " Remap for rename current word
        nmap gm <Plug>(coc-rename)
        " Show documentation in preview window
        nmap <silent> gh :call CocAction('doHover')<CR>
        nmap <silent> gdd :CocList diagnostics<CR>
        nmap <silent> go :CocList outline<CR>
        nmap <silent> gs :CocList -I symbols<CR>
    endif

    " }}} Plugin Config - coc.nvim "

    " Plugin Config - AsyncRun {{{ "

    if filereadable(expand("~/.ysvim/plugged/asyncrun.vim/plugin/asyncrun.vim"))
        nnoremap <silent> <expr> & ':AsyncRun -post=cw ' . input('>') . '<CR>'
        nnoremap <silent> <expr> g& ':AsyncRun -save -post=copen -strip ' . input('>', 'rg --vimgrep ' . expand('<cword>') . ' %') . '<CR>'
    endif

    " }}} Plugin Config - AsyncRun "

    " Plugin Config - tagbar {{{ "

    if filereadable(expand("~/.ysvim/plugged/tagbar/autoload/tagbar.vim"))
        nnoremap <silent> <Leader>b :TagbarToggle<CR>
    endif

    " }}} Plugin Config - tagbar "

endif

" }}} Plugin Config "

" }}} Plugins List & Config "

" Use ~/.ysvim/vimrc.after if exists
if filereadable(expand("~/.ysvim/vimrc.after"))
    source $HOME/.ysvim/vimrc.after
endif

" vim:set et sw=4 ts=4 fdm=marker fdl=1 noma:
