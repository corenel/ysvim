" Name:     ys-vim: sensible vim and neovim configuration
" Desc:     My custom config for Vim8 and NeoVim, partly referred to ashfinal/vimrc-config, statico/dotfiles and liuchengxu/space-vim.
" Author:   corenel <xxdsox@gmail.com>
" URL:      https://github.com/corenel/ysvim
" License:  MIT license

scriptencoding utf8

" Plugin List {{{

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
                call dein#add('Shougo/dein.vim', {'hook_source': 'call ysvim#config#dein()'})

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
                    " call dein#add('kana/vim-operator-user')
                    " call dein#add('kana/vim-textobj-function')
                    " call dein#add('kana/vim-textobj-user')
                    " call dein#add('kana/vim-operator-replace',
                    "         \ {'on_map': '<Plug>', 'depends': 'vim-operator-user'})
                    " call dein#add('rhysd/vim-operator-surround',
                    "         \ {'on_map': '<Plug>', 'depends': 'vim-operator-user'})

                    " Git:
                    " call dein#add('tpope/vim-fugitive')
                    " call dein#add('junegunn/gv.vim')
                    call dein#add('lambdalisue/gina.vim', {'on_cmd': 'Gina', 'hook_source': "call ysvim#config#gina()"})
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
                    call dein#add('terryma/vim-multiple-cursors', { 'on_map' : { 'n' : ['<C-n>', '<C-p>'], 'x' : '<C-n>'}, {'hook_source': 'call ysvim#config#vim_multiple_cursors()'})
                    call dein#add('tpope/vim-commentary')
                    call dein#add('tpope/vim-repeat', {'on_map' : '.'})
                    call dein#add('tpope/vim-surround', {'on_map': {'n' : ['cs', 'ds', 'ys'], 'x' : 'S'}, 'depends' : 'vim-repeat'})
                    call dein#add('roxma/vim-paste-easy')
                    call dein#add('roxma/vim-tmux-clipboard')
                    call dein#add('majutsushi/tagbar', {'hook_source': 'call ysvim#config#tagbar()'})

                " }}} Enhancement

                " Intellisense {{{

                    " Deoplete:
                    call dein#add('Shougo/deoplete.nvim', {'hook_source': 'call ysvim#config#deoplete()'})
                    "" Deopleet Suorces:
                    call dein#add('Shougo/neco-vim', {'on_ft': ['vim'], 'on_source': ['deoplete.nvim']})
                    call dein#add('Shougo/neoinclude.vim', {'on_ft': ['c', 'cpp', 'objc', 'objcpp'], 'on_source': ['deoplete.nvim']})
                    call dein#add('Shougo/neosnippet-snippets')
                    call dein#add('Shougo/neosnippet.vim', {'depends': ['neosnippet-snippets']}) 
                    call dein#add('zchee/deoplete-jedi', {'on_ft': ['python', 'cython', 'pyrex']})
                    call dein#add('zchee/deoplete-clang', {'on_ft': ['c', 'cpp', 'objc', 'objcpp']})
                    call dein#add('zchee/deoplete-docker', {'on_ft': ['dockerfile']})
                    call dein#add('zchee/deoplete-zsh', {'on_ft': ['sh', 'zsh']})
                    "" Deopleet Support:
                    call dein#add('Shougo/echodoc.vim', {'on_event': 'CompleteDone', 'hook_source': 'call echodoc#enable()'})
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
                    call dein#add('lervag/vimtex', {'on_ft': ['tex', 'latex'], 'hook_source': 'call ysvim#config#vimtex()'})

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

" }}} Plugin List

