" Name:     ys-vim: sensible vim and neovim configuration
" Desc:     My custom config for Vim8 and NeoVim, partly referred to ashfinal/vimrc-config, statico/dotfiles and liuchengxu/space-vim.
" Author:   corenel <xxdsox@gmail.com>
" URL:      https://github.com/corenel/ysvim
" License:  MIT license

scriptencoding utf8

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

        if g:ysvim_nvim
            set clipboard+=unnamedplus
        elseif g:ysvim_vim8
            " Enable clipboard if possible
            if has('clipboard')
                if has('unnamedplus') " When possible use + register for copy-paste
                    set clipboard=unnamed,unnamedplus
                else " On mac and Windows, use * register for copy-paste
                    set clipboard=unnamed
                endif
            endif

            " if $TMUX ==# ''
            "     set clipboard+=unnamed
            " endif
        endif


        " set viminfo
        let &viminfo.='100,n'.g:ysvim_home.'/files/info/viminfo'

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
                                    " r - auto insert comments leader  in insert mode
                                    " o - auto insert comments leader in normal mode
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
        " set linebreak               " Break long lines by word, not char
        " set nolist

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

        set scroll=4                " Number of lines to scroll with ^U/^D
        set scrolloff=15            " Keep cursor away from this many chars top/bot
        set sidescrolloff=3         " Keep cursor away from this many chars left/right

        set virtualedit=onemore

        " }}} Navigation

        " History {{{

        set viewoptions=folds,cursor,unix,slash " Better Unix / Windows compatibility

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

        if !isdirectory(expand(g:ysvim_home . '/undotree'))
            call mkdir(g:ysvim_home . '/undotree', 'p')
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
    " let g:mapleader = ','
    " let g:maplocalleader = ','
    let g:mapleader = get(g:, 'ysvim_leader', "\<Space>")
    let g:maplocalleader = get(g:, 'ysvim_localleader', ',')

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
    nmap \r :NERDTreeFind<CR>
    nmap \f mt:Goyo<CR>'tzz
    nmap \g :Gstatus<CR>
    nmap \h :nohlsearch<CR>
    nmap \i vip:sort<CR>
    nmap \o :set paste!<CR>:set paste?<CR>
    nmap \p :ProseMode<CR>
    nmap \v :Startify<CR>
    nmap \x :cclose<CR>
    nmap \z :w<CR>:!open %<CR><CR>

    " Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with
    " line wrapping on, this can cause the cursor to actually skip a few lines on the screen because
    " it's moving from line N to line N+1 in the file. I want this to act more visually -- I want `down'
    " to mean the next line on the screen
    nmap j gj
    nmap k gk

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
    " nnoremap <space> za
    " vnoremap <space> zf

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
            " set complete+=s
            " set background=light
            " if !has('gui_running')
            "     let g:solarized_termcolors=256
            " endif
            " colors solarized
        endfunction
        command! ProseMode call ProseMode()

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

" Filetype triggers {{{

" Reset all autocommands
augroup custom_filetype
    autocmd!
    au BufNewFile,BufRead *.ini     setf conf
    au BufNewFile,BufRead *.md      setlocal ft=markdown
    au BufNewFile,BufRead *.plist   setf xml
    au BufNewFile,BufRead COMMIT_EDITMSG setlocal nolist nonumber
    au BufNewFile,BufRead Makefile setlocal nolist
augroup END
" }}} Filetype triggers
