" Name:     ys-vim: sensible vim and neovim configuration
" Desc:     My custom config for Vim8 and NeoVim, partly referred to ashfinal/vimrc-config and statico/dotfiles
" Author:   corenel xxdsox@gmail.com>
" URL:      https://github.com/corenel/dotfiles
" License:  MIT license

" Init {{{

    " Platform-specific settings {{{

        let g:MAC = has('macunix')
        let g:LINUX = has('unix') && !has('macunix') && !has('win32unix')
        let g:WINDOWS = has('win32') || has('win64')

        if g:WINDOWS
            echo 'Not tested on Windows.'
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif

    " }}} Platform-specific settings

    " Framework setiings {{{

        let g:ysvim_dir = $HOME . '/.ysvim'
        let g:ysvim_version = '0.1.0'
        lockvar g:ysvim_version

        " Create frameworkj root directory if not exists
        if !isdirectory(expand(g:ysvim_root))
            call mkdir(g:ysvim_root, 'p')
        endif

        let g:ysvim_nvim = has('nvim') && exists('*jobwait') && !g:WINDOWS
        let g:ysvim_vim8 = exists('*job_start')
        let g:ysvim_gui = has('gui_running')
        let g:ysvim_tmux = !empty($TMUX)

    " }}} Framework setiings

    " Plugin manager {{{

        " Use Pathgon for plugin management.
        " let g:ysvim_pathogen_enable = 1
        " let g:ysvim_pathogen_dir = g:ysvim_dir . '/bundle/vim-pathogen/autoload/pathogen.vim'
        " runtime g:ysvim_pathogen_dir
        " call pathogen#infect()
        " call pathogen#helptags()

        " Use Vim-Plug
        let g:ysvim_plug_enable = 1
        let g:ysvim_plug_dir = g:ysvim_dir.'/plugged'
        let g:ysvim_plug_vim = g:ysvim_plug_dir . '/plug.vim/vim-plug/plug.vim'
        let g:ysvim_plug_vim_dir = g:ysvim_plug_dir . '/plug.vim/vim-plug'
        set runtimepath+=g:ysvim_plug_vim_dir

        " Use Dein.vim
        " let g:ysvim_dein_enable = 1
        " let g:ysvim_dein_repo = 'https://github.com/Shougo/dein.vim.git'
        " let g:ysvim_dein_dir = g:ysvim_dir . '/dein'
        " let g:ysvim_dein_vim_dir = g:ysvim_dein_dir . '/repos/github.com/Shougo/dein.vim'
        " if !isdirectory(expand(g:ysvim_dein_dir))
        "     call mkdir(g:ysvim_dein_dir, 'p')
        "     exec '!git clone ' . g:ysvim_dein_repo . ' ' . g:ysvim_dein_vim_dir
        " endif
        " set runtimepath+=g:ysvim_dein_dir

    " }}} Plugin manager

" }}} Init

" General {{{

    " Environment - Options, Encoding, Indent, Fold {{{

        " Options {{{

        " if &compatible
        "     set nocompatible
        " endif

        set notitle                 " Don't set the title of the Vim window
        set ttyfast                 " Improves smoothness of redrawing
        set lazyredraw              " Don't redraw while excuting macros

        set noerrorbells            " No annoying sound on errors
        set visualbell t_vb=        " No flashing or beeping at all

        set infercase               " Completion recognizes capitalization
        set matchtime=2             " Tenths of second to highlight matching partten
        set modelines=5             " How many lines of head & tail to look for ml's
        set suffixes+=.pyc          " Ignore these files when tab-completing

        set backspace=indent,eol,start
                                    " Allow backspace beyond insertion point

        silent! set mouse=nvc       " Use the mouse, but not in insert mode

        " Enable clipboard if possible
        " if has('clipboard')
        "     if has('unnamedplus') " When possible use + register for copy-paste
        "         set clipboard=unnamed,unnamedplus
        "     else " On mac and Windows, use * register for copy-paste
        "         set clipboard=unnamed
        "     endif
        " endif

        if $TMUX ==# ''
            set clipboard+=unnamed
        endif

        " set viminfo
        set viminfo='100,n$HOME/.vim/files/info/viminfo

        " }}} Options

        " Encoding {{{

        set encoding=utf8           " UTF-8 by default
        scriptencoding utf8
        set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
        set termencoding=utf-8

        set fileformats=unix,mac,dos  " Prefer Unix
        set fillchars=vert:\ ,stl:\ ,stlnc:\ ,fold:-,diff:┄
                                    " Unicode chars for diffs/folds, and rely on
                                    " Colors for window borders
        set formatoptions=tcqn1     " t - autowrap normal text
                                    " c - autowrap comments
                                    " q - gq formats comments
                                    " n - autowrap lists
                                    " 1 - break _before_ single-letter words
                                    " 2 - use indenting from 2nd line of para
        set printoptions=paper:letter " US paper

        " }}} Encoding

        " Indent {{{

        set autoindent              " Carry over indenting from previous line
        set smartindent
        set cindent                 " Automatic program indenting
        set cinkeys-=0#             " Comments don't fiddle with indenting
        set cinoptions=                   " See :h cinoptions-values
        set copyindent              " Make autoindent use the same chars as prev line

        set expandtab               " No tabs
        set smarttab
        set shiftround              " Shift to certain columns, not just n spaces
        set shiftwidth=4            " Number of spaces to shift for autoindent or >,<
        set softtabstop=4           " Spaces 'feel' like tabs
        set tabstop=4               " The One True Tab
        set textwidth=100           " 100 is the new 80

        filetype on
        filetype plugin on
        filetype plugin indent on

        set wrap
        " set iskeyword+=-
        set whichwrap+=<,>,h,l,[,]
        set linebreak               " Break long lines by word, not char

        " }}} Indent

        " Fold {{{

        set foldlevel=0           " Fold all by default
        silent! set foldmethod=marker " Use braces by default
        set commentstring=\ \ #%s   " When folds are created, add them to this

        " }}} Fold

    " }}} Environment - Encoding, Indent, Fold

    " Appearence - Show, Scrollbar, Color, Numberline {{{

        " Show {{{

        set list                    " Show whitespace as special chars - see listchars
        set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:· " Unicode characters for various things
        set ruler                   " Show row/col and percentage
        set showbreak=              " Show for lines that have been wrapped, like Emacs
        set showmatch               " Hilight matching braces/parens/etc.

        set cursorline              " Hightlight current line
        set mousehide               " Hide mouse pointer when typing characters
        set guicursor+=a:blinkon0   " No cursor blink

        set cmdheight=1             " Limit Height of the command bar
        set wildmenu                " Show possible completions on command line
        set wildmode=list:longest,full " List all options and complete
        " Ignore certain files in tab-completion
        set wildignore=*.class,*.o,*~,*.pyc,*.swp,*.bak,*.pyo,*/.DS_Store,.vscode,.git,node_modules

        " }}} Show

        " Scrollbar {{{

        " Disable scrollbars
        set guioptions-=r
        set guioptions-=R
        set guioptions-=l
        set guioptions-=L

        " }}} Scrollbar

        " Color {{{

        " Make sure colored syntax mode is on, and make it Just Work with 256-color terminals.
        set background=dark
        let g:rehash256 = 1 " Something to do with Molokai?
        colorscheme molokai
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

        " Window splits & ruler are too bright, so change to white on grey (non-GUI)
        highlight StatusLine       cterm=NONE ctermbg=blue ctermfg=white
        highlight StatusLineTerm   cterm=NONE ctermbg=blue ctermfg=white
        highlight StatusLineNC     cterm=NONE ctermbg=black ctermfg=white
        highlight StatusLineTermNC cterm=NONE ctermbg=black ctermfg=white
        highlight VertSplit        cterm=NONE ctermbg=black ctermfg=white

        " taglist.vim's filenames is linked to LineNr by default, which is too dark
        highlight def link MyTagListFileName Statement
        highlight def link MyTagListTagName Question

        " Turn off horrible coloring for CDATA in XML
        highlight def link xmlCdata NONE

        " Some custom spell-checking colors
        highlight SpellBad     term=underline cterm=underline ctermbg=NONE ctermfg=205
        highlight SpellCap     term=underline cterm=underline ctermbg=NONE ctermfg=33
        highlight SpellRare    term=underline cterm=underline ctermbg=NONE ctermfg=217
        highlight SpellLocal   term=underline cterm=underline ctermbg=NONE ctermfg=72

        " The Ignore color should be... ignorable
        silent! highlight Ignore cterm=bold ctermfg=black ctermbg=bg
        highlight clear FoldColumn
        highlight def link FoldColumn Ignore
        highlight clear Folded
        highlight link Folded Ignore
        highlight clear LineNr
        highlight! def link LineNr Ignore

        " Custom search colors
        highlight clear Search
        highlight Search term=NONE cterm=NONE ctermfg=white ctermbg=black

        " Make hilighted matching parents less annoying
        highlight clear MatchParen
        highlight link MatchParen Search

        " Custom colors for NERDTree
        highlight def link NERDTreeRO NERDTreeFile

        " Make trailing spaces very visible
        highlight SpecialKey ctermbg=Yellow guibg=Yellow

        " Make menu selections visible
        highlight PmenuSel ctermfg=black ctermbg=magenta

        " The sign column slows down remote terminals
        highlight clear SignColumn
        highlight link SignColumn Ignore

        " Markdown could be more fruit salady
        highlight link markdownH1 PreProc
        highlight link markdownH2 PreProc
        highlight link markdownLink Character
        highlight link markdownBold String
        highlight link markdownItalic Statement
        highlight link markdownCode Delimiter
        highlight link markdownCodeBlock Delimiter
        highlight link markdownListMarker Todo

        " }}} Color

        " Numberline {{{

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

        " }}} Numberline

    " }}} Appearence - Scrollbar, Color, Numberline

    " Edit - Navigation, History, Search {{{

        " Navigation {{{

        " Map jk to enter normal mode
        imap jk <Esc>

        " Make cursor always on center of screen by default
        " if !exists('noalwayscenter')
        "     " Calculate proper scrolloff
        "     augroup centercursor:
        "       autocmd!
        "       autocmd VimEnter,WinEnter,VimResized,InsertLeave * :let &scrolloff = float2nr(floor(winheight(0)/2)+1)
        "       autocmd InsertEnter * :let &scrolloff = float2nr(floor(winheight(0)/2))
        "     augroup END
        "     " Use <Enter> to keep center in insert mode, need proper scrolloff
        "     inoremap <CR> <CR><C-o>zz
        " endif

        " Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with
        " line wrapping on, this can cause the cursor to actually skip a few lines on the screen because
        " it's moving from line N to line N+1 in the file. I want this to act more visually -- I want `down'
        " to mean the next line on the screen
        nmap j gj
        nmap k gk

        set scroll=4                " Number of lines to scroll with ^U/^D
        set scrolloff=15            " Keep cursor away from this many chars top/bot
        set sidescrolloff=3         " Keep cursor away from this many chars left/right

        set virtualedit=onemore

        " }}} Navigation

        " History {{{

        set viewoptions=folds,cursor,unix,slash " Better Unix / Windows compatibility

        " Save workspace and try to restore last session
        " set sessionoptions=buffers,curdir,tabpages
        " augroup savesession:
        "   autocmd VimLeave * exe ':mksession! $HOME/.vim/.last.session'
        " augroup END

        " Restore last session automatically (Default Off)
        " augroup loadsession:
        "   autocmd VimEnter * :call RestoreLastSession()
        " augroup END

        " function! RestoreLastSession()
        "     if exists('g:restorelastsession')
        "         if filereadable(expand('$HOME/.vim/.last.session'))
        "            exe ':source $HOME/.vim/.last.session'
        "        endif
        "    endif
        " endfunction

        " if filereadable(expand('$HOME/.vim/.last.session'))
        "     nmap <silent> <Leader>l :source $HOME/.vim/.last.session<CR>
        " endif

        " Return to last edit position when opening files (You want this!)
        augroup lastpos:
            autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \     exe "normal! g`\"" |
                \ endif
        augroup END

        " Visually select the text that was last edited/pasted
        nmap gV `[v`]

        set autoread                " Don't bother me hen a file changes
        set autowrite               " Write on :next/:prev/^Z
        set updatetime=200

        " Set how many lines of history VIM has to remember
        set history=1000 " command line history
        set undoreload=1000

        " Turn backup off, since most stuff is in SVN, git etc anyway...
        set directory-=.            " Don't store temp files in cwd
        set nobackup
        set nowritebackup
        set noswapfile
        set shortmess+=A            " Don't bother me when a swapfile exists
        set sessionoptions-=options " Don't save runtimepath in Vim session (see tpope/vim-pathogen docs)

        " Turn persistent undo on, means that you can undo even when you close a buffer/VIM
        set undofile
        set undolevels=1000

        if !isdirectory(expand('$HOME/.vim/undotree'))
            call mkdir($HOME . '/.vim/undotree', 'p')
        endif
        set undodir=~/.vim/undotree
        " }}} History

        " Search {{{

        set magic                   " reg expr
        set hlsearch                " Hilight searching
        set ignorecase              " Case insensitive
        set incsearch               " Search as you type
        set smartcase               " Lets you search for ALL CAPS
        " set nowrapscan              " Don't wrap around when jumping between search result

        " Disable highlight when <Enter> is pressed
        nnoremap <silent> <BS> :nohlsearch<CR>

        " }}} Search

    " }}} Edit - Navigation, History, Search

    " Buffer - BufferSwitch, FileExplorer, StatusLine {{{

        set hidden                  " Don't prompt to save hidden windows until exit
        set autochdir               " Change current working directory automatically

        " BufferSwitch {{{

        " Specify the behavior when switching between buffers
        set switchbuf=useopen

        " }}} BufferSwitch

        " FileExplorer {{{

        set splitright " Puts new vsplit windows to the right of the current
        set splitbelow " Puts new split windows to the bottom of the current

        " }}} FileExplorer

        " StatusLine {{{

        set laststatus=2                           " Always show the status bar
        " set statusline=%<%f                        " filename
        " set statusline+=\ %w%h%m%r                 " option
        " set statusline+=\ [%{&ff}]/%y              " fileformat/filetype
        " set statusline+=\ [%{getcwd()}]            " current dir
        " set statusline+=\ [%{&encoding}]           " encoding
        " set statusline+=%=%-14.(%l/%L,%c%V%)\ %p%% " Right aligned file nav info

        " }}} StatusLine

    " }}} Buffer - BufferSwitch, FileExplorer, StatusLine

    " Key Mappings {{{

    " Map ; to : and save a million keystrokes
    map ; :

    " For any plugins that use this, make their keymappings use comma
    let g:mapleader = ','
    let g:maplocalleader = ','

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
    nmap \A :set formatoptions+=a<CR>:echo "autowrap enabled"<CR>
    nmap \a :set formatoptions-=a<CR>:echo "autowrap disabled"<CR>
    nmap \c :CLEAN<CR>:TEOL<CR>
    nmap \e :NERDTreeToggle<CR>
    nmap \f mt:Goyo<CR>'tzz
    nmap \g :Gstatus<CR>
    nmap \h :nohlsearch<CR>
    nmap \i vip:sort<CR>
    nmap \o :set paste!<CR>:set paste?<CR>
    nmap \p :ProseMode<CR>
    nmap \v :Startify<CR>
    nmap \x :cclose<CR>
    nmap \z :w<CR>:!open %<CR><CR>

    " You don't know what you're missing if you don't use this.
    nmap <C-e> :e#<CR>

    " Move between open buffers.
    nmap <C-n> :bnext<CR>
    nmap <C-p> :bprev<CR>

    " Move between open tabs.
    nmap <C-f> :tabnext<CR>
    nmap <C-b> :tabprev<CR>

    " Add new line without entering insert mode
    nmap <S-Enter> O<Esc>
    nmap <CR> o<Esc>

    " Emacs-like bindings in insert mode
    imap <C-e> <C-o>$
    imap <C-a> <C-o>0

    " Emacs-like bindings in the command line from `:h emacs-keys`
    cnoremap <C-a>  <Home>
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

    " Super fast window movement shortcuts
    " nmap <C-j> <C-W>j
    " nmap <C-k> <C-W>k
    " nmap <C-h> <C-W>h
    " nmap <C-l> <C-W>l

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

    " Ctrl-[kj]: Move lines up/down
    " nnoremap <silent> <C-j> :m .+1<CR>==
    " nnoremap <silent> <C-k> :m .-2<CR>==
    " inoremap <silent> <C-j> <Esc>:m .+1<CR>==gi
    " inoremap <silent> <C-k> <Esc>:m .-2<CR>==gi
    vnoremap <silent> <C-j> :m '>+1<CR>gv=gv
    vnoremap <silent> <C-k> :m '<-2<CR>gv=gv

    " Search for the word under the cursor in the current directory
    nmap <M-k>    mo:Ack! "\b<cword>\b" <CR>
    nmap <Esc>k   mo:Ack! "\b<cword>\b" <CR>
    nmap <M-S-k>  mo:Ggrep! "\b<cword>\b" <CR>
    nmap <Esc>K   mo:Ggrep! "\b<cword>\b" <CR>

    " Alt-W to delete a buffer and remove it from the list but keep the window via bufkill.vim
    nmap <Esc>w :BD<CR>

    " Quickly fix spelling errors choosing the first result
    nmap <Leader>z z=1<CR><CR>

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

        " Debugging helpers
        augroup debug
            autocmd!
            autocmd BufEnter *.py iabbr xxx print('XXX')
            autocmd BufEnter *.py iabbr yyy print('YYY')
            autocmd BufEnter *.py iabbr zzz print('ZZZ')
        augroup END

        " Trim spaces at EOL and retab. I run `:CLEAN` a lot to clean up files.
        command! TEOL %s/\s\+$//
        command! CLEAN retab | TEOL

        " Close all buffers except this one
        command! BufCloseOthers %bd|e#

        " Custom mode for distraction-free editing
        function! ProseMode()
            call goyo#execute(0, [])
            set spell noci nosi noai nolist noshowmode noshowcmd
            set complete+=s
            " set background=light
            " if !has('gui_running')
            "     let g:solarized_termcolors=256
            " endif
            " colors solarized
        endfunction
        command! ProseMode call ProseMode()

        " }}} Custom commands and functions

        " Other {{{

        " Toggle tmux statusline automatically
        " if exists('$TMUX')
        "     augroup tmuxstatusbar:
        "         autocmd!
        "         autocmd VimEnter,VimLeave * :silent !tmux set status
        "     augroup END
        " endif

        " }}} Other

    " }}} Misc

" }}} General

" Plugin List {{{

    " Use Vim-Plug
    if exists(g:ysvim_plug_enable)
        if filereadable(expand(g:ysvim_plug_vim))
            " Specify a directory for plugins
            " - For Neovim: ~/.local/share/nvim/plugged
            " - Avoid using standard Vim directory names like 'plugin'
            " Make sure you use single quote
            call plug#begin('~/.vim/plugged')

            Plug 'bling/vim-airline'
            if version >= 704 || version ==703 && has('patch005')
                Plug 'mbbill/undotree'
            endif
            Plug 'mattn/emmet-vim'
            Plug 'scrooloose/nerdtree'
            Plug 'dhruvasagar/vim-table-mode'
            if executable('node')
                Plug 'maksimr/vim-jsbeautify'
            endif
            if executable('ag')
                Plug 'gabesoft/vim-ags'
            end
            Plug 'tpope/vim-surround'
            Plug 'terryma/vim-multiple-cursors'
            Plug 'kshenoy/vim-signature'
            Plug 'scrooloose/nerdcommenter'
            Plug 'Raimondi/delimitMate'
            if version >= 704
                Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
            endif
            Plug 'ashfinal/vim-align'
            Plug 'junegunn/goyo.vim'
            Plug 'junegunn/limelight.vim'
            Plug 'ctrlpvim/ctrlp.vim'
            Plug 'vim-scripts/YankRing.vim'
            if version >= 704
                Plug 'airblade/vim-gitgutter'
            endif
            if version >= 800 || has('nvim')
                Plug 'skywind3000/asyncrun.vim'
            end
            if executable('latexmk')
                Plug 'lervag/vimtex'
            end
            Plug 'metakirby5/codi.vim'
            Plug 'ashfinal/vim-one'
            if has('nvim')
                if has('python3')
                    Plug 'roxma/nvim-completion-manager'
                    if executable('npm')
                        Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
                    end
                end
            else
                if version >= 703 && has('lua')
                    Plug 'Shougo/neocomplete.vim'
                endif
                if executable('npm')
                    Plug 'ternjs/tern_for_vim', {'do': 'npm install'}
                end
            endif
            if filereadable(expand("~/.vimrc.plug"))
                source $HOME/.vimrc.plug
            endif
            call plug#end()
    endif

    " Use Dein.vim
    " if dein#load_state(g:ysvim_dein_dir)
    "     call dein#begin(g:ysvim_dein_dir)

    "     call dein#add(g:ysvim_dein_vim_dir)
    "     call dein#add('Shougo/neocomplete.vim')

    "     call dein#end()
    "     call dein#save_state()
    " endif

" }}} Plugin List

" Plugin Settings {{{

    " fzf {{{

    if filereadable(expand('$HOME/.vim/bundle/fzf.vim/plugin/fzf.vim'))
        " Replaces Ctrl-P, FuzzyFinder and Command-T
        set runtimepath+=/usr/local/opt/fzf
        set runtimepath+=~/.fzf
        nmap <Leader>b :Buffers<CR>
        nmap <Leader>t :Tags<CR>
        nmap <Leader>f :Files<CR>
        nmap <Leader>a :Ag<CR>
    endif

    " }}} fzf

    " ack.vim {{{

    if filereadable(expand('$HOME/.vim/bundle/ack.vim/plugin/ack.vim'))
        " Tell ack.vim to use ag (the Silver Searcher) instead
        let g:ackprg = 'ag --vimgrep'
    endif

    " }}} ack.vim

    " GitGutter {{{

    if filereadable(expand('$HOME/.vim/bundle/vim-gitgutter.vim/plugin/gitgutter.vim'))
        " Styling to use · instead of +/-
        let g:gitgutter_sign_added = '∙'
        let g:gitgutter_sign_modified = '∙'
        let g:gitgutter_sign_removed = '∙'
        let g:gitgutter_sign_modified_removed = '∙'
    endif

    " }}} GitGutter

    " " SuperTab {{{

    " if filereadable(expand('$HOME/.vim/bundle/supertab.vim/plugin/supertab.vim'))
    "     let g:SuperTabLongestEnhanced=1
    "     let g:SuperTabLongestHighlight=1
    " endif

    " " }}} SuperTab

    " incsearch.vim {{{

    if filereadable(expand('$HOME/.vim/bundle/incsearch.vim/plugin/incsearch.vim'))
        " Highlight as I search
        map /  <Plug>(incsearch-forward)
        map ?  <Plug>(incsearch-backward)
        map g/ <Plug>(incsearch-stay)
    endif

    " }}} incsearch.vim

    " YAML frontmatter {{{

    " Highlight YAML frontmatter in Markdown files
    let g:vim_markdown_frontmatter = 1

    " }}} YAML frontmatter

    " ALE {{{

    if filereadable(expand('$HOME/.vim/bundle/ale/plugin/ale.vim'))
        let g:ale_sign_warning = '▲'
        let g:ale_sign_error = '✗'
        highlight link ALEWarningSign String
        highlight link ALEErrorSign Title
        let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

        let g:ale_linters = {
        \   'sh' : ['shellcheck'],
        \   'python': ['autopep8', 'flake8', 'isort', 'mypy', 'yapf'],
        \   'vim': ['vint'],
        \   'xml': ['xmllint'],
        \   'yaml': ['yamllint'],
        \   'text': ['write-good'],
        \   'markdown' : ['mdl'],
        \}

        let g:ale_virtualenv_dir_names = ['.env', 'env', 've-py3', 've', 'virtualenv', '.virtualenvs']

        " fix for python3
        let g:ale_python_autopep8_executable = 'python3'
        let g:ale_python_autopep8_options = '-m autopep8'
        let g:ale_python_flake8_executable = 'python3'
        let g:ale_python_flake8_options = '-m flake8'
        let g:ale_python_mypy_executable = 'python3'
        let g:ale_python_mypy_options = '-m mypy'
        let g:ale_python_isort_executable = 'python3'
        let g:ale_python_isort_options = '-m isort'
        let g:ale_python_yapf_executable = 'python3'
        let g:ale_python_yapf_options = '-m yapf'

        nmap <Leader>en <Plug>(ale_next)
        nmap <Leader>ep <Plug>(ale_previous)
        nnoremap <Leader>ts :ALEToggle<CR>
    endif

    " }}} ALE

    " Lightline {{{

    if filereadable(expand('$HOME/.vim/bundle/lightline.vim/plugin/lightline.vim'))
        let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'filename', 'modified' ] ],
        \   'right': [ [ 'lineinfo' ],
        \              [ 'percent' ],
        \              [ 'readonly', 'linter_warnings', 'linter_errors', 'linter_ok' ],
        \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'component_function': {
        \   'gitbranch': 'fugitive#head',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \ },
        \ 'component_expand': {
        \   'linter_warnings': 'LightlineLinterWarnings',
        \   'linter_errors': 'LightlineLinterErrors',
        \   'linter_ok': 'LightlineLinterOK'
        \ },
        \ 'component_type': {
        \   'readonly': 'error',
        \   'linter_warnings': 'warning',
        \   'linter_errors': 'error'
        \ },
        \ }

        let g:lightline.tabline = {
        \ 'left': [ [ 'tabs' ] ],
        \ 'right': [ [ 'close' ] ]
        \ }
        set showtabline=2  " Show tabline
        set guioptions-=e  " Don't use GUI tabline

        function! LightlineFileformat()
        return winwidth(0) > 70 ? &fileformat : ''
        endfunction

        function! LightlineFiletype()
        return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
        endfunction

        function! LightlineLinterWarnings() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            let l:all_non_errors = l:counts.total - l:all_errors
            return l:counts.total == 0 ? '' : printf('%d ◆', l:all_non_errors)
        endfunction

        function! LightlineLinterErrors() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            let l:all_non_errors = l:counts.total - l:all_errors
            return l:counts.total == 0 ? '' : printf('%d ✗', l:all_errors)
        endfunction

        function! LightlineLinterOK() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            let l:all_non_errors = l:counts.total - l:all_errors
            return l:counts.total == 0 ? '✓ ' : ''
        endfunction

        " Update and show lightline but only if it's visible (e.g., not in Goyo)
        augroup ale
            autocmd!
            autocmd User ALELint call s:MaybeUpdateLightline()
        augroup END

        function! s:MaybeUpdateLightline()
            if exists('#lightline')
                call lightline#update()
            end
        endfunction
    endif

    " }}} Lightline

    " undotree {{{

    if filereadable(expand('$HOME/.vim/bundle/undotree/plugin/undotree.vim'))
        let g:undotree_SplitWidth = 40
        let g:undotree_SetFocusWhenToggle = 1
        nmap <silent> <Leader>u :UndotreeToggle<CR>

        if !isdirectory(expand('$HOME/.vim/.tmp/undotree'))
            call mkdir($HOME . '/.vim/.tmp/undotree', 'p')
        endif

        if has('persistent_undo')
            set undodir='$HOME/.vim/.tmp/undotree'
            set undofile
        endif
    endif

    " }}} undotree

    " ultisnips {{{

    if filereadable(expand('$HOME/.vim/bundle/ultisnips/plugin/UltiSnips.vim'))
        " settings for ultisnips
        let g:UltiSnipsExpandTrigger = '<Tab>'
        let g:UltiSnipsJumpForwardTrigger = '<C-n>'
        let g:UltiSnipsJumpBackwardTrigger = '<C-p>'
        let g:UltiSnipsEditSplit = 'context'
        if !isdirectory(expand('$HOME/.vim/.tmp/ultisnips'))
            call mkdir($HOME . '/.vim/.tmp/ultisnips', 'p')
        endif
        let g:UltiSnipsSnippetsDir = '$HOME/.vim/.tmp/ultisnips'
    endif

    " }}} ultisnips

    " vim-multiple-cursors {{{

    if filereadable(expand('$HOME/.vim/bundle/vim-multiple-cursors/plugin/multiple_cursors.vim'))
        let g:multi_cursor_use_default_mapping = 0
        let g:multi_cursor_next_key = '+'
        let g:multi_cursor_prev_key = '_'
        let g:multi_cursor_skip_key = '-'
        let g:multi_cursor_quit_key = '<Esc>'
        function! Multiple_cursors_before()
            if exists(':NeoCompleteLock') == 2
                exe 'NeoCompleteLock'
            endif
        endfunction
        function! Multiple_cursors_after()
            if exists(':NeoCompleteUnlock') == 2
                exe 'NeoCompleteUnlock'
            endif
        endfunction
    endif
    " }}} vim-multiple-cursors

    " completor.vim {{{

    if filereadable(expand('$HOME/.vim/bundle/completor.vim/plugin/completor.vim'))
        let g:completor_python_binary = '/usr/local/bin/python3'
        let g:completor_clang_binary = '/usr/bin/clang'
        let g:completor_tex_omni_trigger = '\\\\(:?'
                \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
                \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
                \ . '|hyperref\s*\[[^]]*'
                \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
                \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
                \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
                \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
                \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
                \ .')$'

        " set completeopt-=noselect
        " set pumheight=10
        " automatically open and close the popup menu / preview window
        " if !exists('g:noautoclosepum')
        "     autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        " endif

        " inoremap <expr> <Tab> pumvisible() ? '\<C-n>' : '\<Tab>'
        " inoremap <expr> <S-Tab> pumvisible() ? '\<C-p>' : '\<S-Tab>'
        " inoremap <expr> <CR> (pumvisible() ? '\<c-y>\<cr>' : '\<CR>')
    endif

    " }}} completor.vim

    " vim-cpp-enhanced-highlight {{{

    if filereadable(expand('$HOME/.vim/after/syntax/cpp.vim'))
        let g:cpp_class_scope_highlight = 1
        let g:c_no_curly_error=1
    endif

    " }}} vim-cpp-enhanced-highlight

    " vim-autoformat {{{

    if filereadable(expand('$HOME/.vim/bundle/vim-autoformat/plugin/autoformat.vim'))
        let g:formatter_yapf_style = 'google'
        let g:formatters_python = ['yapf']
        let g:formatters_c = ['clangformat']
        let g:formatters_cpp = ['clangformat']
        " let g:autoformat_verbosemode = 1
        augroup vimautoformat:
            autocmd!
            autocmd BufWrite *.py :Autoformat
            autocmd BufWrite *.c,*.h,*.cpp,*.hpp :Autoformat
        augroup End
    endif

    " }}} vim-autoformat

    " vimtex {{{

    if filereadable(expand('$HOME/.vim/bundle/vimtex/autoload/vimtex.vim'))
        "tex preview config
        let g:texflavor = 'latex'
        let g:vimtexviewmethod = 'general'
        let g:vimtexenabled = 1
        let g:vimtexcompleteimgusetail = 1
        let g:vimtexviewgeneralviewer = 'open'
        let g:vimtex_fold_enabled = 1
        let g:vimtexviewgeneraloptions = '-r @line @pdf @tex'
        let g:vimtex_quickfix_mode = 2
        let g:vimtex_quickfix_open_on_warning = 0
        let g:vimtex_quickfix_latexlog = {
                \ 'default' : 1,
                \ 'general' : 1,
                \ 'references' : 1,
                \ 'overfull' : 0,
                \ 'underfull' : 0,
                \ 'font' : 1,
                \ 'packages' : {
                \   'default' : 1,
                \   'natbib' : 1,
                \   'biblatex' : 1,
                \   'babel' : 1,
                \   'hyperref' : 1,
                \   'scrreprt' : 1,
                \   'fixltx2e' : 1,
                \   'titlesec' : 1,
                \ },
                \}
        let g:vimtex_compiler_latexmk = {
                \ 'callback' : 0,
                \ 'options' : [
                \   '-verbose',
                \   '-file-line-error',
                \   '-synctex=1',
                \   '-shell-escape',
                \   '-interaction=nonstopmode',
                \ ],
                \}

    endif

    " }}} vimtex

    " " easymotion {{{

    " if filereadable(expand('$HOME/.vim/bundle/easymotion/autoload/easymotion.vim'))
    "     map <Leader> <Plug>(easymotion-prefix)

    "     " <Leader>f{char} to move to {char}
    "     map  <Leader>f <Plug>(easymotion-bd-f)
    "     nmap <Leader>f <Plug>(easymotion-overwin-f)

    "     " s{char}{char} to move to {char}{char}
    "     nmap s <Plug>(easymotion-overwin-f2)

    "     " Move to line
    "     map <Leader>L <Plug>(easymotion-bd-jk)
    "     nmap <Leader>L <Plug>(easymotion-overwin-line)

    "     " Move to word
    "     map  <Leader>w <Plug>(easymotion-bd-w)
    "     nmap <Leader>w <Plug>(easymotion-overwin-w)
    " endif

    " " }}} easymotion

    " tagbar {{{

    if filereadable(expand('$HOME/.vim/bundle/tagbar/autoload/tagbar.vim'))
        nmap \s :TagbarToggle<CR>
    endif

    " }}} tagbar

    " vimux {{{

    if filereadable(expand('$HOME/.vim/bundle/vimux/plugin/vimux.vim'))
        " Run the current file with python3
        augroup vimuxruncmd:
            autocmd!
            autocmd Filetype python nnoremap <buffer> <Leader>rr :update<Bar>:call VimuxRunCommandInDir("clear; python3 " . bufname("%"), 0)<CR>
        augroup END

        " Run REPL with python3
        map <Leader>rp :call VimuxRunCommand("clear; python3", 0)<CR>

        " Prompt for a command to run
        map <Leader>vp :VimuxPromptCommand<CR>

        " Run last command executed by VimuxRunCommand
        map <Leader>vl :VimuxRunLastCommand<CR>

        " Inspect runner pane
        map <Leader>vi :VimuxInspectRunner<CR>

        " Close vim tmux runner opened by VimuxRunCommand
        map <Leader>vq :VimuxCloseRunner<CR>

        " Interrupt any command running in the runner pane
        map <Leader>vx :VimuxInterruptRunner<CR>

        " Zoom the runner pane (use <bind-key> z to restore runner pane)
        map <Leader>vz :call VimuxZoomRunner()<CR>

        " Toggle pane
        map <Leader>vt :call VimuxTogglePane()<CR>

        " Always use vertical split pane
        let g:VimuxOrientation = 'v'

        " Always create new pane
        let g:VimuxUseNearest = 0

        " Vimux height percent
        let g:VimuxHeight = '20'
    endif

    " }}} vimux

    " startify {{{

    if filereadable(expand('$HOME/.vim/bundle/vim-startify/plugin/startify.vim'))
        augroup startifycustom:
            autocmd!
            autocmd User Startified setlocal cursorline
        augroup END

        let g:startify_bookmarks = [
            \ {'c': '$HOME/.vim/vimrc.local'},
            \ {'z': '$HOME/.zshrc.custom'},
            \ {'h': '$HOME/.ssh/config'},
            \ {'o': '$HOME/Dropbox/Documents/Orgzly/'},
            \ {'w': '$HOME/Workspace/'}
            \ ]

        let g:startify_session_dir        = '$HOME/.vim/.tmp/session'
        let g:startify_change_to_vcs_root = 1
        let g:startify_update_oldfiles    = 1
        let g:startify_change_to_dir      = 1
        let g:startify_files_number       = 8


        hi StartifyBracket ctermfg=240
        hi StartifyFile    ctermfg=147
        hi StartifyFooter  ctermfg=240
        hi StartifyHeader  ctermfg=114
        hi StartifyNumber  ctermfg=215
        hi StartifyPath    ctermfg=245
        hi StartifySlash   ctermfg=240
        hi StartifySpecial ctermfg=240
    endif

    " }}} startify

    " python-mode {{{

    if filereadable(expand('$HOME/.vim/bundle/python-mode/plugin/pymode.vim'))
        " general settings
        let g:pymode_python = 'python3'
        let g:pymode_paths = [
            \ '/usr/local/lib/python3.6/site-packages',
            \ '/usr/local/lib/python3.5/dist-packages'
            \ ]

        " virtualenv
        let g:pymode_virtualenv = 0
        let g:pymode_virtualenv_path = $VIRTUAL_ENV

        " use ale instead of pymode_lint
        let g:pymode_lint = 0

        " use rope for refactoring
        let g:pymode_rope = 1
        let g:pymode_rope_lookup_project = 0
        let g:pymode_rope_autoimport = 1
    endif


    " }}} python-mode

    " vim-orgmode {{{

    if filereadable(expand('$HOME/.vim/bundle/vim-orgmode/syntax/org.vim'))
        let g:org_todo_keywords = ['TODO', 'NEXT', '|', 'DONE']
    endif

    " }}} vim-orgmode

    " " nvim-completion-manager {{{

    " if filereadable(expand('$HOME/.vim/bundle/nvim-completion-manager/plugin/cm.vim'))
    "     " don't give |ins-completion-menu| messages.  For example,
    "     " " '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
    "     set shortmess+=c
    "     " When the <Enter> key is pressed while the popup menu is visible, it only hides the menu.
    "     " Use this mapping to hide the menu and also start a new line.
    "     inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
    "     " Here is an example for expanding snippet in the popup menu with <Enter> key. Suppose you
    "     " use the <C-U> key for expanding snippet.
    "     imap <expr> <CR>  (pumvisible() ?  "\<c-y>\<Plug>(expand_or_nl)" : "\<CR>")
    "     imap <expr> <Plug>(expand_or_nl) (cm#completed_is_snippet() ? "\<C-U>":"\<CR>")
    "     " When using CTRL-C key to leave insert mode, it does not trigger the autocmd InsertLeave.
    "     " You should use CTRL-[, or map the <c-c> to <ESC>.
    "     inoremap <c-c> <ESC>
    "     " Use <TAB> to select the popup menu:
    "     inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    "     inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"\

    "     " settings for ultisnips
    "     let g:ultisnipsexpandtrigger            = '<plug>(ultisnips_expand)'
    "     let g:UltiSnipsJumpForwardTrigger       = '<c-j>'
    "     let g:UltiSnipsJumpBackwardTrigger      = '<c-k>'
    "     let g:UltiSnipsRemoveSelectModeMappings = 0
    "     inoremap <silent> <c-u> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>

    "     " If 'omnifunc' is the only available option, you may register it as a source for NCM.
    "     augroup custom_cm_setup
    "         autocmd!
    "         autocmd User CmSetup call cm#register_source({
    "             \ 'name' : 'vimtex',
    "             \ 'priority': 8,
    "             \ 'scoping': 1,
    "             \ 'scopes': ['tex'],
    "             \ 'abbreviation': 'tex',
    "             \ 'cm_refresh_patterns': g:vimtex#re#ncm,
    "             \ 'cm_refresh': {'omnifunc': 'vimtex#complete#omnifunc'},
    "             \ })
    "     augroup END
    " endif

    " " }}} nvim-completion-manager

" }}} Plugin Settings

" Filetype triggers {{{

" Reset all autocommands
augroup vimrc
    autocmd!
    au BufNewFile,BufRead *.cson    set ft=coffee
    au BufNewFile,BufRead *.glsl    setf glsl
    au BufNewFile,BufRead *.gyp     set ft=python
    au BufNewFile,BufRead *.html    setlocal nocindent smartindent
    au BufNewFile,BufRead *.i7x     setf inform7
    au BufNewFile,BufRead *.ini     setf conf
    au BufNewFile,BufRead *.input   setf gnuplot
    au BufNewFile,BufRead *.json    set ft=json tw=0
    au BufNewFile,BufRead *.less    setlocal ft=less nocindent smartindent
    au BufNewFile,BufRead *.md      setlocal ft=markdown nolist
    au BufNewFile,BufRead *.md,*.markdown setlocal foldlevel=999 tw=0 nocin
    au BufNewFile,BufRead *.ni      setlocal ft=inform nolist ts=2 sw=2 noet
    au BufNewFile,BufRead *.plist   setf xml
    au BufNewFile,BufRead *.rb      setlocal noai
    au BufNewFile,BufRead *.rxml    setf ruby
    au BufNewFile,BufRead *.sass    setf sass
    au BufNewFile,BufRead *.ttml    setf xml
    au BufNewFile,BufRead *.vert,*.frag set ft=glsl
    au BufNewFile,BufRead *.xml     setlocal ft=xml  ts=2 sw=2 et
    au BufNewFile,BufRead *.tex     setlocal tw=0 nocin
    au BufNewFile,BufRead *.zone    setlocal nolist ts=4 sw=4 noet
    au BufNewFile,BufRead *.zsh     setf zsh
    au BufNewFile,BufRead *templates/*.html setf htmldjango
    au BufNewFile,BufRead .git/config setlocal ft=gitconfig nolist ts=4 sw=4 noet
    au BufNewFile,BufRead .gitconfig* setlocal ft=gitconfig nolist ts=4 sw=4 noet
    au BufNewFile,BufRead .vimlocal,.gvimlocal setf vim
    au BufNewFile,BufRead .zsh.custom setf zsh
    au BufNewFile,BufRead /tmp/crontab* setf crontab
    au BufNewFile,BufRead COMMIT_EDITMSG setlocal nolist nonumber
    au BufNewFile,BufRead Makefile setlocal nolist
    au FileType gitcommit setlocal nolist ts=4 sts=4 sw=4 noet
    au FileType python setlocal tw=79
    au FileType inform7 setlocal nolist tw=0 ts=4 sw=4 noet foldlevel=999
    au FileType json setlocal conceallevel=0 foldmethod=syntax foldlevel=999
    au FileType make setlocal nolist ts=4 sts=4 sw=4 noet
    au FileType markdown syn sync fromstart
    au Filetype gitcommit setlocal tw=80
augroup END
" }}} Filetype triggers

" Post {{{

" Now load specifics to this host
if filereadable(expand('$HOME/.vimrc.local'))
    source $HOME/.vimrc.local
endif

" Some plugin seems to search for something at startup, so this fixes that.
silent! nohlsearch

" vim:set tw=100:

" }}} Post
