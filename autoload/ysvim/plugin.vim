" Name:     ys-vim: sensible vim and neovim configuration
" Desc:     My custom config for Vim8 and NeoVim, partly referred to ashfinal/vimrc-config, statico/dotfiles and liuchengxu/space-vim.
" Author:   corenel <xxdsox@gmail.com>
" URL:      https://github.com/corenel/ysvim
" License:  MIT license

scriptencoding utf8

" Plugin List {{{

    " Use Vim-Plug {{{

    function ysvim#plugin#load_vim_plug ()
        if filereadable(expand(g:ysvim_plug_vim))
            set runtimepath+=$HOME/.ysvim/plugged/plug.vim/vim-plug
            call plug#begin(expand(g:ysvim_plug_home))

            " Appearance {{{

                Plug 'itchyny/lightline.vim'
                Plug 'mhinz/vim-startify'
                Plug 'junegunn/goyo.vim'

                " Color Schemes
                Plug 'tomasr/molokai'
                Plug 'altercation/vim-colors-solarized'
                Plug 'ayu-theme/ayu-vim'
                Plug 'morhetz/gruvbox'

            " }}} Appearance

            " Enhancement {{{

                " Git
                Plug 'tpope/vim-fugitive'
                Plug 'junegunn/gv.vim'
                Plug 'airblade/vim-gitgutter'

                " NerdTree
                Plug 'scrooloose/nerdtree'
                Plug 'Xuyuanp/nerdtree-git-plugin'
                Plug 'ryanoasis/vim-devicons' "load nerdtree-git-plugin before VimDevIcons loads.
                Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

                " Tmux
                " Plug 'benmills/vimux'
                Plug 'christoomey/vim-tmux-navigator'

                " Snippets
                Plug 'SirVer/ultisnips'
                Plug 'honza/vim-snippets'

                " Search
                Plug 'haya14busa/incsearch.vim'
                Plug 'mileszs/ack.vim'
                Plug 'junegunn/fzf', { 'do': './install --no-key-bindings --no-completion --no-update-rc' } " only install fzf for vim
                Plug 'junegunn/fzf.vim'

                " Editing
                Plug 'godlygeek/tabular'
                Plug 'mbbill/undotree'
                Plug 'nathanaelkane/vim-indent-guides'
                Plug 'sheerun/vim-polyglot'
                Plug 'terryma/vim-multiple-cursors'
                Plug 'tpope/vim-commentary'
                Plug 'tpope/vim-eunuch'
                Plug 'tpope/vim-repeat'
                Plug 'tpope/vim-rhubarb'
                Plug 'tpope/vim-sleuth'
                Plug 'tpope/vim-speeddating', {'for': 'org'}
                Plug 'tpope/vim-surround'
                Plug 'tpope/vim-unimpaired'

                if g:ysvim_nvim
                    Plug 'roxma/vim-paste-easy'
                endif

                if g:ysvim_vim8
                    Plug 'tmux-plugins/vim-tmux-focus-events'
                endif
                Plug 'roxma/vim-tmux-clipboard'

                " Utils
                Plug 'majutsushi/tagbar'
                Plug 'metakirby5/codi.vim'
                Plug 'roxma/vim-window-resize-easy'

                " Misc
                Plug 'qpkorr/vim-bufkill'
                Plug 'raimondi/delimitmate'
                Plug 'wellle/targets.vim'

            " }}} Enhancement

            " Intellisense {{{

                Plug 'w0rp/ale'
                Plug 'Chiel92/vim-autoformat'

                if g:ysvim_vim8
                    Plug 'maralla/completor.vim'
                elseif  g:ysvim_nvim
                    Plug 'roxma/nvim-completion-manager'
                endif

                " Languages specific plugins
                " Python
                Plug 'python-mode/python-mode', {'for': 'python'}
                Plug 'davidhalter/jedi-vim', {'for': 'python'}
                " C++
                if  g:ysvim_nvim
                    Plug 'roxma/ncm-clang', {'for': ['c', 'cpp']}
                endif
                Plug 'Rip-Rip/clang_complete', {'for': ['c', 'cpp']}
                " HTML
                Plug 'othree/html5.vim', {'for': 'html'}
                Plug 'mattn/emmet-vim', {'for': 'html'}
                Plug 'mustache/vim-mustache-handlebars', {'for': 'html'}
                " CSS
                Plug 'calebeby/ncm-css', {'for': ['html', 'css']}
                " Javascript
                Plug 'ternjs/tern_for_vim', { 'do': 'npm install' } " only install ternjs for vim
                Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
                Plug 'pangloss/vim-javascript', {'for': 'javascript'}
                " Typescript
                Plug 'mhartington/nvim-typescript', {'for': 'typescript'}
                Plug 'HerringtonDarkholme/yats.vim', {'for': 'typescript'}
                " Org-mode
                Plug 'jceb/vim-orgmode', {'for': 'org'}
                " LaTex
                Plug 'lervag/vimtex', {'for': ['bib', 'tex']}
                " Github repos and users
                Plug 'roxma/ncm-github'
                " Markdown
                Plug 'dhruvasagar/vim-table-mode', {'for': 'markdown'}
                Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
                Plug 'mzlogin/vim-markdown-toc', {'for': 'markdown'}
                " Vim Script
                Plug 'lervag/neco-vim', {'for': 'vim'}

            " }}} Intellisense

            call plug#end()
        endif
    endfunction

    " }}} Use Vim-Plug

    " Use Dein.vim {{{

    function ysvim#plugin#load_dein()
        if filereadable(expand(g:ysvim_dein_vim))
            set runtimepath+=$HOME/.ysvim/dein/repos/github.com/Shougo/dein.vim/autoload/dein.vim
            if dein#load_state(expand(g:ysvim_dein_dir))
                call dein#begin(expand(g:ysvim_dein_dir))
                call dein#add(expand(g:ysvim_dein_vim_dir))
                call dein#end()
                call dein#save_state()
            endif

            " Install not installed plugins on startup."
            if dein#check_install()
                call dein#install()
            endif
        endif
        endfunction

    " }}} Use Dein.vim

    " Use Pathogen {{{

    function ysvim#plugin#load_pathogen()
        if filereadable(expand(g:ysvim_pathogen_vim))
            set runtimepath+=$HOME/.ysvim/bundle/vim-pathogen/autoload/pathogen.vim
            call pathogen#infect()
            call pathogen#helptags()
        endif
    endfunction

    " }}} Use Pathogen

" }}} Plugin List

