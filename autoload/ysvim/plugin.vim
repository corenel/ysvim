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
                " Plug 'junegunn/goyo.vim'

                " Color Schemes
                " Plug 'tomasr/molokai'
                " Plug 'altercation/vim-colors-solarized'
                " Plug 'ayu-theme/ayu-vim'
                Plug 'morhetz/gruvbox'

            " }}} Appearance

            " Enhancement {{{

                " Git
                Plug 'tpope/vim-fugitive'
                " Plug 'junegunn/gv.vim'
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
                " Plug 'tpope/vim-speeddating', {'for': 'org'}
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
                " Plug 'metakirby5/codi.vim'
                " Plug 'roxma/vim-window-resize-easy'

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
                " Plug 'jceb/vim-orgmode', {'for': 'org'}
                " LaTex
                Plug 'lervag/vimtex', {'for': ['bib', 'tex']}
                " Github repos and users
                " Plug 'roxma/ncm-github', {'for': 'markdown'}
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
        " Set dein.vim variables
        let g:dein#types#git#clone_depth = 1

        " Check and load dein.vim
        if filereadable(expand(g:ysvim_dein_vim))
            " Add dein to &runtimepath
            execute 'set runtimepath^=' . g:ysvim_dein_vim_dir
            " set runtimepath+=$HOME/.ysvim/dein/repos/github.com/Shougo/dein.vim/autoload/dein.vim

            " Load plugins
            if dein#load_state(expand(g:ysvim_dein_home))
                call dein#begin(expand(g:ysvim_dein_home))

                " Dein:
                call dein#add('Shougo/dein.vim')

                " Appearance {{{

                    call dein#add('itchyny/lightline.vim', {'hook_source': 'call ysvim#config#lightline_vim()'})
                    call dein#add('mhinz/vim-startify', {'hook_source': 'call ysvim#config#vim_startify()'})

                    " Color Schemes:
                    " call dein#add("'tomasr/molokai')
                    " call dein#add('altercation/vim-colors-solarized')
                    " call dein#add('ayu-theme/ayu-vim')
                    call dein#add('morhetz/gruvbox')

                    " Icons:
                    "" load nerdtree-git-plugin before VimDevIcons loads.
                    call dein#add('Xuyuanp/nerdtree-git-plugin')
                    call dein#add('ryanoasis/vim-devicons', {'hook_source': 'call ysvim#config#vim_devicons()'})

                " }}} Appearance

                " Enhancement {{{

                    " Operator:
                    call dein#add('kana/vim-operator-user')
                    call dein#add('kana/vim-textobj-function')
                    call dein#add('kana/vim-textobj-user')
                    call dein#add('kana/vim-operator-replace',
                            \ {'on_map': '<Plug>', 'depends': 'vim-operator-user'})
                    call dein#add('rhysd/vim-operator-surround',
                            \ {'on_map': '<Plug>', 'depends': 'vim-operator-user'})

                    " Git:
                    " call dein#add('tpope/vim-fugitive')
                    " call dein#add('junegunn/gv.vim')
                    call dein#add('airblade/vim-gitgutter')


                    " NerdTree:
                    call dein#add('scrooloose/nerdtree', {'hook_source': 'call ysvim#config#nerdtree()'})
                    call dein#add('tiagofumo/vim-nerdtree-syntax-highlight', {'hook_source': 'call ysvim#config#nerdtree_syntax_highlight()'})

                    " Tmux:
                    " Plug 'benmills/vimux'
                    call dein#add('christoomey/vim-tmux-navigator', {'hook_source': 'call ysvim#config#vim_tmux_navigator()'})

                    " Linter Formatter:
                    call dein#add('neomake/neomake')
                    call dein#add('sbdchd/neoformat', {'on_cmd': 'Neoformat'})

                    " Editing:
                    call dein#add('mbbill/undotree', {'hook_source': 'call ysvim#config#undotree()'})
                    call dein#add('terryma/vim-multiple-cursors', {'hook_source': 'call ysvim#config#vim_multiple_cursors()'})
                    call dein#add('tpope/vim-commentary')
                    call dein#add('tpope/vim-repeat')
                    call dein#add('roxma/vim-paste-easy')
                    call dein#add('roxma/vim-tmux-clipboard')
                    call dein#add('majutsushi/tagbar', {'hook_source': 'call ysvim#config#tagbar()'})

                " }}} Enhancement

                " Intellisense {{{

                    " Deoplete:
                    call dein#add('Shougo/deoplete.nvim')
                    "" Deopleet Suorces:
                    call dein#add('Shougo/neco-vim', {'on_ft': ['vim'], 'on_source': ['deoplete.nvim']})
                    call dein#add('Shougo/neoinclude.vim', {'on_ft': ['c', 'cpp', 'objc', 'objcpp'], 'on_source': ['deoplete.nvim']})
                    call dein#add('Shougo/neosnippet-snippets')
                    call dein#add('Shougo/neosnippet.vim', {'depends': ['neosnippet-snippets']})
                    "" Deopleet Support:
                    " call dein#add('Shougo/echodoc.vim', {'on_event': 'CompleteDone', 'hook_source': 'call echodoc#enable()'})
                    call dein#add('Shougo/neopairs.vim', {'on_event': 'CompleteDone', 'hook_add': 'let g:neopairs#enable = 1'})

                    " Denite:
                    call dein#add('Shougo/denite.nvim')
                    "" Dependency:
                    call dein#add('nixprime/cpsm')
                    "" Denite Suorces:

                    " Language Plugin:
                    "" C Family:
                    call dein#add('vim-jp/vim-cpp')
                    call dein#add('octol/vim-cpp-enhanced-highlight')
                    call dein#add('lyuts/vim-rtags', {'on_ft': ['c', 'cpp', 'objc']})
                    call dein#add('CoatiSoftware/vim-coati', {'on_ft': ['c', 'cpp', 'objc']})

                    "" Python:
                    call dein#add('davidhalter/jedi-vim', {'lazy': 1, 'on_ft': ['python', 'cython', 'pyrex'],'hook_source': 'call ysvim#config#jedi_vim()'})
                    call dein#add('hynek/vim-python-pep8-indent', {'on_ft': ['python', 'cython', 'pyrex']})
                    call dein#add('nvie/vim-flake8', {'on_ft': ['python', 'cython', 'pyrex']})
                    call dein#add('tweekmonster/impsort.vim', {'on_ft': ['python','cython', 'pyrex']})

                    "" TypeScript:
                    call dein#add('leafgarland/typescript-vim', {'on_ft': 'typescript'})
                    call dein#add('HerringtonDarkholme/yats.vim', {'on_ft': 'typescript'})

                    "" Javascript:
                    call dein#add('othree/yajs.vim', {'on_ft': 'javascript'})

                    "" Markdown:
                    call dein#add('moorereason/vim-markdownfmt', {'on_ft': 'markdown'})
                    call dein#add('rhysd/vim-gfm-syntax', {'on_ft': 'markdown'})

                    "" Vim:
                    call dein#add('vim-jp/vimdoc-ja', {'on_ft': 'vim'})
                    call dein#add('vim-jp/syntax-vim-ex', {'on_ft': 'vim'})

                    "" Shell:
                    call dein#add('chrisbra/vim-sh-indent')

                    "" Tex:
                    call dein#add('lervag/vimtex', {'on_ft': ['tex', 'latex']})

                    "" Json:
                    call dein#add('elzr/vim-json', {'on_ft': 'json'})

                    "" Tmux:
                    call dein#add('tmux-plugins/vim-tmux')

                " }}} Intellisense

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

