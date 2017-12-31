" Name:     ys-vim: sensible vim and neovim configuration
" Desc:     My custom config for  NeoVim, partly referred to ashfinal/vimrc-config, statico/dotfiles and liuchengxu/space-vim.
" Author:   corenel <xxdsox@gmail.com>
" URL:      https://github.com/corenel/ysvim
" License:  MIT license

scriptencoding utf8

" General Settings {{{

    " Environment - Options, Encoding, Indent, Fold {{{

        " Options {{{

        " if &compatible
        "     set nocompatible
        " endif

        set notitle                 " Don't set the title of the Vim window
        set ttyfast                 " Improves smoothness of redrawing
        set nolazyredraw            " Redraw while excuting macros
        " set nojoinspaces
        " set noshiftround
        set noshowcmd
        set nostartofline
        " set nowrapscan

        set belloff=all
        set noerrorbells            " No annoying sound on errors
        set novisualbell            " No flashing or beeping at all

        set modelines=1             " How many lines of head & tail to look for ml's
        set suffixes+=.pyc          " Ignore these files when tab-completing

        set backspace=indent,eol,start
                                    " Allow backspace beyond insertion point

        silent! set mouse=nvc       " Use the mouse, but not in insert mode

        set clipboard=unnamed,unnamedplus

        " set complete=.  " default: .,w,b,u,t
        set completeopt=menu,noinsert,noselect

        " Terminel settings
        let g:terminal_scrollback_buffer_size = 100000

        " set viminfo
        let &viminfo.='100,n'.g:ysvim_home.'/files/info/viminfo'

        " }}} Options

        " Encoding {{{

        set encoding=utf8           " UTF-8 by default
        set fileencodings=utf8,chinese,taiwan,japan,korea,ansi
        set termencoding=utf-8

        set fileformats=unix,mac,dos  " Prefer Unix
        set fillchars=vert:\ ,stl:\ ,stlnc:\ ,fold:-,diff:┄
                                    " Unicode chars for diffs/folds, and rely on
                                    " Colors for window borders
        set formatoptions+=1  " 1 - break _before_ single-letter words
        " set formatoptions+=1  " 2 - use indenting from 2nd line of para
        set formatoptions+=c  " Autowrap comments using textwidth
        set formatoptions+=j  " Delete comment character when joining commented lines
        set formatoptions+=l  " do not wrap lines that have been longer when starting insert mode already
        set formatoptions+=n  " Recognize numbered lists
        " set formatoptions+=o  " Insert comment leader after hitting o or O in normal mode
        set formatoptions+=q  " Allow formatting of comments with "gq".
        set formatoptions+=r  " Insert comment leader after hitting <Enter>
        set formatoptions+=t  " Auto-wrap text using textwidth

        set printoptions=paper:letter " US paper

        set helplang& helplang=en   " Hey, if true Vim master, use English help language.


        " }}} Encoding

        " Indent {{{

        set autoindent              " Carry over indenting from previous line
        set smartindent
        set cindent                 " Automatic program indenting
        set cinkeys-=0#             " Comments don't fiddle with indenting
        set cinoptions=             " See :h cinoptions-values
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
        set list

        " }}} Indent

        " Fold {{{

        set foldlevel=0               " Fold all by default
        set foldcolumn=0
        set foldnestmax=1             " maximum fold depth
        silent! set foldmethod=marker " Use braces by default
        set commentstring=\ \ #%s     " When folds are created, add them to this

        set nofoldenable

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
        set concealcursor=niv       " Conceal neosnippet markers
        set conceallevel=2

        set cmdheight=2             " Limit Height of the command bar
        set wildmenu                " Show possible completions on command line
        " List all options and complete
        set wildmode=longest,list:full  " http://stackoverflow.com/a/526940/5228839
        " Ignore certain files in tab-completion
        set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png            " image
        set wildignore+=*.manifest                                " gb
        set wildignore+=*.o,*.obj,*.exe,*.dll,*.so,*.out,*.class  " compiler
        set wildignore+=*.swp,*.swo,*.swn,*.bak                   " vim
        set wildignore+=*/.git,*/.hg,*/.svn                       " vcs
        set wildignore+=tags,*.tags                               " tags
        set wildignore+=*.pyc,*.pyo                               " Python
        set wildignore+=*/.DS_Store                               " macOS
        set wildignore+=node_modules                              " NodeJS

        set colorcolumn=79

        set previewheight=15
        set pumheight=25

        " font setting
        if g:ysvim_linux
            set guifont=Meslo\ LG\ M\ DZ\ for\ Powerline\ Nerd\ Font\ Complete\ 14
        endif

        if g:ysvim_macos || g:ysvim_windows
            set guifont=MesloLGMDZ\ Nerd\ Font:h14
        endif

        " }}} Show

        " Scrollbar {{{

        " Disable scrollbars
        set guioptions-=r
        set guioptions-=R
        set guioptions-=l
        set guioptions-=L

        " }}} Scrollbar

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
            colorscheme gruvbox
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
        if !exists('noalwayscenter')
            " Calculate proper scrolloff
            augroup centercursor:
              autocmd!
              autocmd VimEnter,WinEnter,VimResized,InsertLeave * :let &scrolloff = float2nr(floor(winheight(0)/2)+1)
              autocmd InsertEnter * :let &scrolloff = float2nr(floor(winheight(0)/2))
            augroup END
            " Use <Enter> to keep center in insert mode, need proper scrolloff
            inoremap <CR> <CR><C-o>zz
        endif

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

        " }}} History

        " Search {{{

        set magic                   " reg expr
        set hlsearch                " Hilight searching
        set ignorecase              " Case insensitive
        set incsearch               " Search as you type
        set inccommand=nosplit
        set smartcase               " Lets you search for ALL CAPS
        " set nowrapscan              " Don't wrap around when jumping between search result
        set infercase               " Completion recognizes capitalization
        set matchtime=2             " Tenths of second to highlight matching partten
        set maxmempattern=2000000

        " set regexpengine=2

        " Disable highlight when <Enter> is pressed
        nnoremap <silent> <BS> :nohlsearch<CR>

        " }}} Search

    " }}} Edit - Navigation, History, Search

    " Buffer - BufferSwitch, FileExplorer, StatusLine {{{

        set hidden                  " Don't prompt to save hidden windows until exit
        set noautochdir             " Don't change current working directory automatically

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
    nnoremap ; :

    " For any plugins that use this, make their keymappings use comma
    let g:mapleader = get(g:, 'ysvim_leader', ',')
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
    " nmap \A :set formatoptions+=a<CR>:echo 'autowrap enabled'<CR>
    " nmap \a :set formatoptions-=a<CR>:echo 'autowrap disabled'<CR>
    nmap \c :CLEAN<CR>:TEOL<CR>
    nmap \e :Vaffle<CR>
    nmap \g :Gstatus<CR>
    nmap \h :nohlsearch<CR>
    nmap \i vip:sort<CR>
    nmap \l :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<CR>
    nmap \o :set paste!<CR>:set paste?<CR>
    nmap \v :Startify<CR>
    nmap \x :cclose<CR>
    nmap \z :w<CR>:!open %<CR><CR>

    " Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with
    " line wrapping on, this can cause the cursor to actually skip a few lines on the screen because
    " it's moving from line N to line N+1 in the file. I want this to act more visually -- I want `down'
    " to mean the next line on the screen
    " nmap j gj
    " nmap k gk
    nmap j <Plug>(accelerated_jk_gj_position)
    nmap k <Plug>(accelerated_jk_gk_position)

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
        Gautocmd BufWritePre *.sh\|bash Neomake

        " Markdown:
        Gautocmdft markdown let g:sh_noisk=1

        " Neosnippet:
        Gautocmdft neosnippet call dein#source('neosnippet.vim')
        " Clear neosnippet markers when InsertLeave
        Gautocmd InsertLeave * NeoSnippetClearMarkers

        " Gitcommit:
        Gautocmd BufEnter COMMIT_EDITMSG startinsert
        Gautocmdft gina-commit startinsert

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

" }}} General Settings

" Plugin Settings {{{

    " Appearance {{{

        " Lightline.vim {{{

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
              return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
          endfunction

          function! LightlineFiletype()
              return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
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

        " }}} Lightline.vim

        " vim-startify {{{

          augroup startifycustom:
              autocmd!
              autocmd User Startified setlocal cursorline
          augroup END

          let g:startify_bookmarks = [
              \ {'c': g:ysvim_home},
              \ {'d': '$HOME/.dotfiles'},
              \ {'z': '$HOME/.zshrc'},
              \ {'u': '$HOME/.zshrc.custom'},
              \ {'m': '$HOME/.tmux.conf'},
              \ {'h': '$HOME/.ssh/config'},
              \ {'w': '$HOME/Workspace/'},
              \ ]

          let g:startify_session_dir        = g:ysvim_cache . '/session'
          let g:startify_change_to_vcs_root = 1
          let g:startify_update_oldfiles    = 1
          let g:startify_change_to_dir      = 1
          let g:startify_files_number       = 8

          " if g:ysvim_color ==# 'molokai'
          "     hi StartifyBracket ctermfg=240
          "     hi StartifyFile    ctermfg=147
          "     hi StartifyFooter  ctermfg=240
          "     hi StartifyHeader  ctermfg=114
          "     hi StartifyNumber  ctermfg=215
          "     hi StartifyPath    ctermfg=245
          "     hi StartifySlash   ctermfg=240
          "     hi StartifySpecial ctermfg=240
          " endif

      " }}} vim-startify

      " vim-devicons {{{

        " loading the plugin
        let g:webdevicons_enable = 1
        " adding the flags to NERDTree
        let g:webdevicons_enable_nerdtree = 1
        " turn on/off file node glyph decorations (not particularly useful)
        let g:WebDevIconsUnicodeDecorateFileNodes = 1
        let g:DevIconsEnableFoldersOpenClose = 1
        " use double-width(1) or single-width(0) glyphs
        " only manipulates padding, has no effect on terminal or set(guifont) font
        let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
        " whether or not to show the nerdtree brackets around flags
        let g:webdevicons_conceal_nerdtree_brackets = 1
        " the amount of space to use after the glyph character (default ' ')
        let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
        " Force extra padding in NERDTree so that the filetype icons line up vertically
        let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
        " specify OS to decide an icon for unix fileformat (not defined by default)
        " this is useful for avoiding unnecessary system() call.
        " let g:WebDevIconsOS = 'Darwin'

        " }}} vim-devicons

    " }}} Appearance

    " Enhancement {{{

        " undotree {{{

          let g:undotree_SplitWidth = 40
          let g:undotree_SetFocusWhenToggle = 1
          nmap <silent> <Leader>u :UndotreeToggle<CR>

          call ysvim#util#check_dir(g:ysvim_cache . '/undotree')
          if has('persistent_undo')
              let &undodir = g:ysvim_cache . '/undotree'
              set undofile
          endif

        " }}} undotree

        " vim-multiple-cursors {{{

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

        " }}} vim-multiple-cursors

        " tagbar {{{

          nmap \s :TagbarToggle<CR>
          " The tags are not sorted according to their name
          let g:tagbar_sort = 0

        " }}} tagbar

        " vim-tmux-navigator {{{

          " disbale default key bindings of plugin
          " let g:tmux_navigator_no_mappings = 1
          " nnoremap <silent> <C-w><C-h> :TmuxNavigateLeft<cr>
          " nnoremap <silent> <C-w><C-j> :TmuxNavigateDown<cr>
          " nnoremap <silent> <C-w><C-k> :TmuxNavigateUp<cr>
          " nnoremap <silent> <C-w><C-k> :TmuxNavigateRight<cr>
          " nnoremap <silent> <C-w><C-k> :TmuxNavigatePrevious<cr>

          " Write all buffers before navigating from Vim to tmux pane
          let g:tmux_navigator_save_on_switch = 2

          " Disable tmux navigator when zooming the Vim pane
          let g:tmux_navigator_disable_when_zoomed = 1

        " }}} vim-tmux-navigator

        " " NerdTree {{{
        "
        "   let g:NERDTreeQuitOnOpen=1
        "
        " " }}} NerdTree

        " vim-nerdtree-syntax-highlight {{{

          " Disable Highlighting
          " let g:NERDTreeDisableFileExtensionHighlight = 1
          " let g:NERDTreeDisableExactMatchHighlight = 1
          " let g:NERDTreeDisablePatternMatchHighlight = 1

          " Highlight full name (not only icons). You need to add this if you don't have vim-devicons and want highlight.
          let g:NERDTreeFileExtensionHighlightFullName = 1
          let g:NERDTreeExactMatchHighlightFullName = 1
          let g:NERDTreePatternMatchHighlightFullName = 1

          " Highlight folders using exact match
          let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
          let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

          " Disable Highlight for specific file extension
          " If you have vim-devicons you can customize your icons for each file type.
          " let g:NERDTreeExtensionHighlightColor = {} "this line is needed to avoid error
          " let g:NERDTreeExtensionHighlightColor['css'] = '' "assigning it to an empty string will skip highlight
          "
          " Disable uncommon file extensions highlighting (this is a good idea if you are experiencing lag when scrolling)
          let g:NERDTreeLimitedSyntax = 1

          " Disable all default file extensions highlighting (you can use this to easily customize which extensions you want to highlight)
          " let g:NERDTreeSyntaxDisableDefaultExtensions = 1

          " Customize which file extensions are enabled (you only need this if you set g:NERDTreeLimitedSyntax or g:NERDTreeSyntaxDisableDefaultExtensions)
          " set g:NERDTreeExtensionHighlightColor if you want a custom color instead of the default one
          " let g:NERDTreeSyntaxEnabledExtensions = ['hbs', 'lhs'] " enable highlight to .hbs and .lhs files with default colors

        " }}} vim-nerdtree-syntax-highlight

        " Gina {{{

        " }}} Gina

        " GitGutter {{{

          let g:gitgutter_eager = 1
          let g:gitgutter_enabled = 1
          let g:gItgutter_highlight_lines = 0
          let g:gitgutter_map_keys = 0
          let g:gitgutter_max_signs = 1000
          let g:gitgutter_realtime = 0
          set signcolumn=yes

        " }}} GitGutter

        " ale {{{

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
          nnoremap <Leader>es :ALEToggle<CR>

        " }}} ale

        " accelerated-jk {{{

          let g:accelerated_jk_acceleration_limit = 50
          let g:accelerated_jk_acceleration_table = [3, 15, 25, 35]

        " }}} accelerated-jk

        " Denite {{{

        " }}} Denite

        " Vaffle {{{

          let g:vaffle_auto_cd = 1
          let g:vaffle_force_delete = 1
          let g:vaffle_show_hidden_files = 1

        " }}} Vaffle

        " QuickRun {{{

          Gautocmd WinEnter *
                \ if winnr('$') == 1 &&
                \   getbufvar(winbufnr(winnr()), "&filetype") == "quickrun" |
                \ q |
                \ endif
          let g:quickrun_config = get(g:, 'quickrun_config', {})
          let g:quickrun_config._ = {
                \ 'runner' : 'vimproc',
                \ 'runner/vimproc/updatetime' : 50,
                \ 'outputter' : 'quickfix',
                \ 'outputter/quickfix/open_cmd' : 'copen 35',
                \ 'outputter/buffer/running_mark' : ''
                \ }
          " Go
          let g:quickrun_config.go = {
                \ 'command': 'run',
                \ 'cmdopt' : '',
                \ 'exec': ['go %c %s %o -'],
                \ 'outputter' : 'buffer',
                \ 'outputter/buffer/split' : 'vertical botright 100',
                \ 'outputter/buffer/close_on_empty' : 1,
                \ }

        " }}} QuickRun

        " " Neomake {{{
        "
        "   let g:neomake_open_list = 2
        "   let g:neomake_python_enabled_makers = ['pyflakes', 'flake8']
        "
        " " }}} Neomake

        " SonicTemplate {{{

          let g:sonictemplate_vim_template_dir = [
                \ g:ysvim_home . '/template'
                \]

        " }}} SonicTemplate

    " }}} Enhancement

    " Intellisense {{{

        " python-mode {{{

          " general settings
          let g:pymode_python = 'python3'
          let g:pymode_paths = [
              \ '/usr/local/lib/python3.6/site-packages',
              \ '/usr/local/lib/python3.5/dist-packages'
              \ ]

          " virtualenv
          let g:pymode_virtualenv = 1
          let g:pymode_virtualenv_path = $VIRTUAL_ENV

          " use ale instead of pymode_lint
          let g:pymode_lint = 0

          " use rope for refactoring
          " DISABLE ropr and USE jedi.vim INSTEAD
          let g:pymode_rope = 0
          let g:pymode_rope_lookup_project = 0
          let g:pymode_rope_autoimport = 1
          let g:pymode_rope_complete_on_dot = 0

        " }}} python-mode

        " vimtex {{{

          let g:polyglot_disabled = ['latex']

          "tex preview config
          let g:texflavor = 'latex'
          let g:tex_flavor = 'latex'
          let g:vimtex_view_method = 'skim'
          let g:vimtex_view_enabled = 1
          let g:vimtex_view_general_viewer = 'open'
          let g:vimtex_fold_enabled = 1
          let g:vimtex_view_general_options = '-r @line @pdf @tex'
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
                  \ 'options' : [
                  \   '-pdf',
                  \   '-verbose',
                  \   '-file-line-error',
                  \   '-synctex=1',
                  \   '-interaction=nonstopmode',
                  \   '-shell-escape',
                  \ ],
                  \}

          " If 'omnifunc' is the only available option, you may register it as a source for NCM.
          " augroup custom_cm_setup
          "     autocmd!
          "     if exists(':VimtexCompile')
          "         autocmd User CmSetup call cm#register_source({
          "             \ 'name' : 'vimtex',
          "             \ 'priority': 8,
          "             \ 'scoping': 1,
          "             \ 'scopes': ['tex'],
          "             \ 'abbreviation': 'tex',
          "             \ 'cm_refresh_patterns': g:vimtex#re#ncm,
          "             \ 'cm_refresh': {'omnifunc': 'vimtex#complete#omnifunc'},
          "             \ })
          "     endif
          " augroup END

        " }}} vimtex

        " jedi.vim {{{

          " don't initialize
          let g:jedi#auto_initialization = 0
          let g:jedi#auto_vim_configuration = 0
          let g:jedi#use_splits_not_buffers = ''
          let g:jedi#completions_enabled = 0
          let g:jedi#documentation_command = "K"
          let g:jedi#max_doc_height = 150
          let g:jedi#popup_select_first = 0
          let g:jedi#show_call_signatures = 0
          let g:jedi#smart_auto_mappings = 0
          let g:jedi#force_py_version = 3

          " key bindings
          let g:jedi#goto_command = '<leader>jc'
          let g:jedi#goto_assignments_command = '<leader>jg'
          let g:jedi#goto_definitions_command = '<leader>jd'
          let g:jedi#documentation_command = '<leader>jk'
          let g:jedi#usages_command = '<leader>jn'
          let g:jedi#completions_command = '<C-Space>'
          let g:jedi#rename_command = '<leader>jr'

        " }}} jedi.vim

        " Deoplete {{{

        " let g:acp_enableAtStartup = 0
        " let g:deoplete#auto_complete_start_length = 1
        " let g:deoplete#sources#syntax#min_keyword_length = 3

        let g:deoplete#auto_complete_delay = 0
        let g:deoplete#enable_at_startup = 1
        let g:deoplete#enable_camel_case = 0
        let g:deoplete#enable_ignore_case = 0
        let g:deoplete#enable_refresh_always = 0
        let g:deoplete#auto_refresh_delay = 100
        let g:deoplete#enable_smart_case = 1
        let g:deoplete#file#enable_buffer_path = 1
        let g:deoplete#max_list = 10000

        " Define keyword.
        if !exists('g:deoplete#keyword_patterns')
          let g:deoplete#keyword_patterns = {}
        endif
        let g:deoplete#keyword_patterns['default'] = '\h\w*'

        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
          " return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
          " For no inserting <CR> key.
          return pumvisible() ? "\<C-y>" : "\<CR>"
        endfunction
        " <TAB>: completion.
        " inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
        " Close popup by <Space>.
        " inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

        " Enable omni completion.
        Gautocmdft go,python,ruby setlocal omnifunc=
        " autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        " autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        " autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

        " Enable heavy omni completion.
        " if !exists('g:deoplete#omni#input_patterns')
        "   let g:deoplete#omni#input_patterns = {}
        " endif
        "let g:deoplete#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        "let g:deoplete#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        "let g:deoplete#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

        " Ignore:
        let g:deoplete#ignore_sources = {} " Initialize
        let g:deoplete#ignore_sources._ = ['around']
        let g:deoplete#ignore_sources.go =
              \ ['buffer', 'dictionary', 'member', 'omni', 'tag', 'syntax', 'around'] " wtf what around?
        let g:deoplete#ignore_sources.python =
              \ ['buffer', 'dictionary', 'member', 'omni', 'tag', 'syntax', 'around'] " file/include conflicting deoplete-jedi
        let g:deoplete#ignore_sources.c =
              \ ['dictionary', 'member', 'omni', 'tag', 'syntax', 'file/include', 'neosnippet', 'around']
        let g:deoplete#ignore_sources.cpp    = g:deoplete#ignore_sources.c
        let g:deoplete#ignore_sources.objc   = g:deoplete#ignore_sources.c

        let g:deoplete#sources#clang#libclang_path = '/usr/local/lib/libclang.dylib'
        let g:deoplete#sources#clang#clang_header = '/usr/local/lib/clang'
        let g:deoplete#sources#clang#flags = [
          \ '-I/usr/include',
          \ '-I/usr/local/include',
          \ ] " echo | clang -v -E -x c -
          " \ '-isysroot', $XCODE_DIR.'/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk',
        let g:deoplete#sources#jedi#statement_length = 0
        let g:deoplete#sources#jedi#short_types = 0
        let g:deoplete#sources#jedi#show_docstring = 1
        let g:deoplete#sources#jedi#worker_threads = 2
        let g:deoplete#sources#jedi#python_path = g:python3_host_prog


        " }}} Deoplete

        " neosnippet {{{

          " Plugin key-mappings.
          " Note: It must be 'imap' and 'smap'.  It uses <Plug> mappings.
          imap <C-o>     <Plug>(neosnippet_expand_or_jump)
          smap <C-o>     <Plug>(neosnippet_expand_or_jump)
          xmap <C-o>     <Plug>(neosnippet_expand_target)

          " SuperTab like snippets behavior.
          " Note: It must be 'imap' and 'smap'.  It uses <Plug> mappings.
          imap <C-o>     <Plug>(neosnippet_expand_or_jump)
          imap <expr><TAB>
           \ pumvisible() ? "\<C-n>" :
           \ neosnippet#expandable_or_jumpable() ?
           \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
          smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
          \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

          " For conceal markers.
          if has('conceal')
            set conceallevel=2 concealcursor=niv
          endif

          " Enable snipMate compatibility feature.
          " let g:neosnippet#enable_snipmate_compatibility = 1
          " Tell Neosnippet about the other snippets
          let g:neosnippet#snippets_directory = g:ysvim_home . '/neosnippets'
          let g:neosnippet#snippets_directory .= ', ' . g:ysvim_dein_home . '/repos/github.com/Shougo/neosnippet-snippets/neosnippets'
          " let g:neosnippet#snippets_directory .= ', ' . g:ysvim_dein_home . '/repos/github.com/honza/vim-snippets/snippets'

          let g:neosnippet#data_directory = g:ysvim_cache . '/neosnippet'
          let g:neosnippet#enable_complete_done = 1
          let g:neosnippet#enable_completed_snippet = 1
          let g:neosnippet#expand_word_boundary = 0
          let g:neosnippet_username = 'corenel'
          let g:snips_author = 'Yusu Pan'
          let g:neosnippet#disable_runtime_snippets = {
            \   'c': 1,
            \ 'cpp': 1,
            \  'go': 1,
            \ }

        " }}} neosnippet

        " neopairs {{{

          let g:neopairs#enable = 1

        " }}} neopairs

        " rtags {{{

          let g:rtagsJumpStackMaxSize = 1000
          let g:rtagsMaxSearchResultWindowHeight = 15
          let g:rtagsMinCharsForCommandCompletion = 100
          let g:rtagsUseDefaultMappings = 0
          let g:rtagsUseLocationList = 1

        " }}} rtags

        " vim-cpp-enhanced-highlight {{{

          let g:cpp_class_scope_highlight = 1
          let g:cpp_experimental_template_highlight = 1
          let g:cpp_concepts_highlight = 1

        " }}} vim-cpp-enhanced-highlight

        " clang-format {{{

          let g:clang_format#auto_format = 0
          let g:clang_format#auto_format_on_insert_leave = 0
          let g:clang_format#auto_formatexpr = 1
          let g:clang_format#command = '/usr/local/bin/clang-format'
          let g:clang_format#detect_style_file = 1
          let g:clang_format#style_options = {
                \ 'Standard' : 'C++11',
                \ 'AllowShortIfStatementsOnASingleLine' : 'true',
                \ 'AlwaysBreakTemplateDeclarations' : 'true',
                \ 'AccessModifierOffset' : -4
                \ }

        " }}} clang-format

        " vim-flake8 {{{

          let g:python_highlight_all = 1
          " let g:flake8_cmd = $HOME.'/.local/bin/flake8'
          let g:flake8_show_in_gutter = 1

        " }}} vim-flake8

        " autopep8 {{{

          let g:autopep8_aggressive = 1
          let g:autopep8_disable_show_diff = 1

        " }}} autopep8

        " impsort {{{

          let g:impsort_highlight_imported = 1
          let g:impsort_highlight_star_imports = 1

        " }}} impsort

        " vim-markdownfmt {{{

          let g:markdownfmt_autosave = 0
          Gautocmd InsertLeave *.md,*.slide call vimproc#system("issw 'com.apple.keyboardlayout.Programmer Dvorak.keylayout.ProgrammerDvorak'")

        " }}} vim-markdownfmt

        " vim-gfm-syntax {{{

          " http://mattn.kaoriya.net/software/vim/20140523124903.html
          let g:markdown_fenced_languages = [
                \ 'c',
                \ 'cpp',
                \ 'python',
                \ 'sh',
                \ 'vim',
                \ 'asm',
                \]
          let g:slide_fenced_languages = [
                \ 'sh',
                \ 'c',
                \ 'cpp',
                \ 'python',
                \ 'vim',
                \ 'asm',
                \]

        " }}} vim-gfm-stntax

    " }}} Intellisense

" }}} Plugin Settings
