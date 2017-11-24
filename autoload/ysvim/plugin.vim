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
                Plug 'tomasr/molokai'
                Plug 'altercation/vim-colors-solarized'
                Plug 'ayu-theme/ayu-vim'
                Plug 'morhetz/gruvbox'

            " }}} Appearance

            " Enhancement {{{

                " Git
                Plug 'tpope/vim-fugitive'
                Plug 'airblade/vim-gitgutter'

                " NerdTree
                Plug 'scrooloose/nerdtree'
                Plug 'Xuyuanp/nerdtree-git-plugin'
                " you should load nerdtree-git-plugin before VimDevIcons.
                Plug 'ryanoasis/vim-devicons'
                Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

                " Tmux
                Plug 'benmills/vimux'
                Plug 'christoomey/vim-tmux-navigator'

                " Snippets
                Plug 'SirVer/ultisnips'
                Plug 'honza/vim-snippets'

                " Utils
                Plug 'haya14busa/incsearch.vim'
                Plug 'terryma/vim-multiple-cursors'
                Plug 'tpope/vim-commentary'
                Plug 'junegunn/fzf.vim'
                Plug 'junegunn/goyo.vim'
                Plug 'majutsushi/tagbar'
                Plug 'mbbill/undotree'
                Plug 'mileszs/ack.vim'

                " Misc
                Plug 'nathanaelkane/vim-indent-guides'
                Plug 'qpkorr/vim-bufkill'
                Plug 'raimondi/delimitmate'
                Plug 'sheerun/vim-polyglot'
                Plug 'tpope/vim-eunuch'
                Plug 'tpope/vim-repeat'
                Plug 'tpope/vim-rhubarb'
                Plug 'tpope/vim-sleuth'
                Plug 'tpope/vim-speeddating'
                Plug 'tpope/vim-surround'
                Plug 'tpope/vim-unimpaired'
                Plug 'wellle/targets.vim'

            " }}} Enhancement

            " Intellisense {{{

                Plug 'w0rp/ale'
                Plug 'Chiel92/vim-autoformat'

                if g:ysvim_vim8
                    Plug 'maralla/completor.vim'
                elseif  g:ysvim_nvim
                    Plug 'roxma/nvim-completion-manager'
                    Plug 'roxma/ncm-clang'
                endif

            " }}} Intellisense

            " Feature {{{

                Plug 'jceb/vim-orgmode'
                Plug 'lervag/vimtex'
                Plug 'python-mode/python-mode'

            " }}} Feature

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

