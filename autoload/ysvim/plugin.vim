" Name:     ys-vim: sensible vim and neovim configuration
" Desc:     My custom config for NeoVim, partly referred to ashfinal/vimrc-config, statico/dotfiles and liuchengxu/space-vim.
" Author:   corenel <xxdsox@gmail.com>
" URL:      https://github.com/corenel/ysvim
" License:  MIT license

scriptencoding utf8

" Dein Hook Function {{{

  " Deoplete {{{

    function! DeopleteHookFunc()
        call deoplete#custom#source('_', 'converters', ['converter_auto_paren', 'converter_remove_overlap'])
        call deoplete#custom#source('_', 'min_pattern_length', 1)
        call deoplete#custom#source('buffer', 'rank', 100)
        call deoplete#custom#source('jedi', 'disabled_syntaxes', ['Comment'])
        call deoplete#custom#source('jedi', 'matchers', ['matcher_fuzzy'])
        call deoplete#custom#source('neosnippet', 'disabled_syntaxes', ['goComment'])"
        call deoplete#custom#source('vim', 'disabled_syntaxes', ['Comment'])
    endfunction

  " }}} Deoplete

  " Vimtex {{{

    function! VimtexHookFunc()
        call deoplete#custom#var('omni', 'input_patterns', {
                \ 'tex': g:vimtex#re#deoplete
                \})
    endfunction

  " }}} Vimtex

" }}} Dein Hook Function

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
                call dein#add('Shougo/dein.vim')

                " Appearance {{{

                    call dein#add('itchyny/lightline.vim')
                    call dein#add('mhinz/vim-startify')

                    " Color Schemes:
                    " call dein#add("'tomasr/molokai')
                    " call dein#add('altercation/vim-colors-solarized')
                    " call dein#add('ayu-theme/ayu-vim')
                    call dein#add('morhetz/gruvbox')

                    " Icons:
                    " load nerdtree-git-plugin before VimDevIcons loads.
                    " call dein#add('Xuyuanp/nerdtree-git-plugin')
                    " call dein#add('ryanoasis/vim-devicons')

                " }}} Appearance

                " Enhancement {{{

                    " Operator:
                    call dein#add('kana/vim-operator-user')
                    call dein#add('kana/vim-textobj-function')
                    call dein#add('kana/vim-textobj-user')
                    call dein#add('kana/vim-textobj-indent')
                    call dein#add('sgur/vim-textobj-parameter')
                    call dein#add('kana/vim-operator-replace',
                            \ {'on_map': '<Plug>', 'depends': 'vim-operator-user'})
                    call dein#add('rhysd/vim-operator-surround',
                            \ {'on_map': '<Plug>', 'depends': 'vim-operator-user'})
                    call dein#add('tpope/vim-unimpaired')

                    " Git:
                    " call dein#add('tpope/vim-fugitive')
                    " call dein#add('junegunn/gv.vim')
                    call dein#add('airblade/vim-gitgutter')

                    " File Manager:
                    " call dein#add('scrooloose/nerdtree')
                    " call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
                    call dein#add('cocopon/vaffle.vim')

                    " Tmux:
                    " Plug 'benmills/vimux'
                    call dein#add('christoomey/vim-tmux-navigator')
                    call dein#add('roxma/vim-tmux-clipboard')
                    call dein#add('tmux-plugins/vim-tmux-focus-events')

                    " Linter Formatter:
                    " call dein#add('neomake/neomake')
                    call dein#add('w0rp/ale')
                    call dein#add('sbdchd/neoformat', {'on_cmd': 'Neoformat'})

                    " Editing:
                    " call dein#add('terryma/vim-multiple-cursors', {'on_map': {'n': ['<C-n>', '<C-p>'], 'x': '<C-n>'}})
                    call dein#add('haya14busa/vim-asterisk', {'on_map': '<Plug>'})
                    " call dein#add('tyru/caw.vim')
                    call dein#add('tpope/vim-commentary')
                    call dein#add('tpope/vim-repeat', {'on_map' : '.'})
                    call dein#add('tpope/vim-surround', {'on_map': {'n' : ['cs', 'ds', 'ys'], 'x' : 'S'}, 'depends' : 'vim-repeat'})
                    " call dein#add('roxma/vim-paste-easy')
                    " call dein#add('itchyny/vim-parenmatch', {'on_event': 'VimEnter'})

                    " Utils:
                    " call dein#add('thinca/vim-quickrun', {'on_cmd': 'QuickRun'})
                    " call dein#add('majutsushi/tagbar')
                    call dein#add('haya14busa/dein-command.vim', {'on_cmd': 'Dein'})
                    " call dein#add('mattn/sonictemplate-vim', {'on_cmd': 'Template'})
                    call dein#add('rhysd/accelerated-jk', {'on_map': '<Plug>'})
                    call dein#add('mbbill/undotree')
                    call dein#add('tpope/vim-obsession')

                    " Lifelog:
                    call dein#add('wakatime/vim-wakatime')

                    " LeaderF:
                    " call dein#add('Yggdroot/LeaderF',  {'build': 'sh -c "./install.sh"'})

                " }}} Enhancement

                " Intellisense {{{

                    " Deoplete:
                    call dein#add('Shougo/deoplete.nvim', {'hook_add': 'call DeopleteHookFunc()'})
                    "" Deoplete Suorces:
                    call dein#add('Shougo/neco-vim', {'on_ft': ['vim'], 'on_source': ['deoplete.nvim']})
                    call dein#add('Shougo/neco-syntax', {'on_source': ['deoplete.nvim']})
                    call dein#add('Shougo/neoinclude.vim', {'on_ft': ['c', 'cpp', 'objc', 'objcpp'], 'on_source': ['deoplete.nvim']})
                    " call dein#add('honza/vim-snippets')
                    call dein#add('Shougo/neosnippet.vim')
                    call dein#add('Shougo/neosnippet-snippets')
                    call dein#add('zchee/deoplete-jedi', {'on_ft': ['python', 'cython', 'pyrex']})
                    call dein#add('zchee/deoplete-clang', {'on_ft': ['c', 'cpp', 'objc', 'objcpp']})
                    call dein#add('zchee/deoplete-docker', {'on_ft': ['dockerfile']})
                    call dein#add('zchee/deoplete-zsh', {'on_ft': ['sh', 'zsh']})
                    "" Deoplete Support:
                    call dein#add('Shougo/echodoc.vim', {'on_event': 'CompleteDone', 'hook_source': 'call echodoc#enable()'})
                    call dein#add('Shougo/neopairs.vim', {'on_event': 'CompleteDone', 'hook_add': 'let g:neopairs#enable = 1'})

                    " Language Plugin:
                    "" C Family:
                    " call dein#add('vim-jp/vim-cpp', {'on_ft': ['c', 'cpp', 'objc', 'objcpp']})
                    call dein#add('octol/vim-cpp-enhanced-highlight', {'on_ft': ['c', 'cpp', 'objc', 'objcpp']})
                    " call dein#add('lyuts/vim-rtags', {'on_ft': ['c', 'cpp', 'objc', 'objcpp']})
                    call dein#add('vim-scripts/DoxygenToolkit.vim', {'on_ft': ['c', 'cpp', 'objc', 'objcpp']})
                    call dein#add('ludovicchabant/vim-gutentags', {'on_ft': ['c', 'cpp', 'objc', 'objcpp', 'tex', 'latex']})
                    call dein#add('vim-scripts/a.vim', {'on_ft': ['c', 'cpp', 'objc', 'objcpp']})

                    "" Python:
                    call dein#add('davidhalter/jedi-vim', {'lazy': 1, 'on_ft': ['python', 'cython', 'pyrex']})
                    call dein#add('hynek/vim-python-pep8-indent', {'on_ft': ['python', 'cython', 'pyrex']})
                    call dein#add('nvie/vim-flake8', {'on_ft': ['python', 'cython', 'pyrex']})
                    call dein#add('tweekmonster/impsort.vim', {'on_ft': ['python','cython', 'pyrex']})
                    call dein#add('heavenshell/vim-pydocstring', {'on_ft': ['python','cython', 'pyrex']})

                    "" TypeScript:
                    " call dein#add('leafgarland/typescript-vim', {'on_ft': 'typescript'})
                    " call dein#add('HerringtonDarkholme/yats.vim', {'on_ft': 'typescript'})

                    "" Javascript:
                    " call dein#add('othree/yajs.vim', {'on_ft': 'javascript'})

                    "" Markdown:
                    call dein#add('moorereason/vim-markdownfmt', {'on_ft': 'markdown'})
                    call dein#add('rhysd/vim-gfm-syntax', {'on_ft': 'markdown'})

                    "" Vim:
                    " call dein#add('vim-jp/syntax-vim-ex', {'on_ft': 'vim'})

                    "" Shell:
                    call dein#add('chrisbra/vim-sh-indent', {'on_ft': ['sh']})

                    "" Tex:
                    call dein#add('lervag/vimtex', {'on_ft': ['tex', 'latex'], 'hook_post_source': 'call VimtexHookFunc()'})

                    "" Json:
                    call dein#add('elzr/vim-json', {'on_ft': 'json'})

                    "" Tmux:
                    call dein#add('tmux-plugins/vim-tmux')

                " }}} Intellisense

                call dein#end()
                call dein#save_state()
            endif

            " Install not installed plugins on startup."
            if !has('vim_starting') && dein#check_install()
                call dein#install()
            endif
        endif
    endfunction

    " }}} Use Dein.vim

" }}} Plugin List

" Plugins to be ignored {{{

    let g:did_install_default_menus = 1 " $VIMRUNTIME/menu.vim
    let g:did_menu_trans            = 1 " $VIMRUNTIME/menu.vim
    let g:load_doxygen_syntax       = 1 " $VIMRUNTIME/syntax/doxygen.vim
    let g:loaded_2html_plugin       = 1 " $VIMRUNTIME/plugin/tohtml.vim
    let g:loaded_gzip               = 1 " $VIMRUNTIME/plugin/gzip.vim
    let g:loaded_less               = 1 " $VIMRUNTIME/macros/less.vim
    let g:loaded_matchit            = 1 " $VIMRUNTIME/plugin/matchit.vim
    let g:loaded_matchparen         = 1 " $VIMRUNTIME/plugin/matchparen.vim
    let g:loaded_netrw              = 1 " $VIMRUNTIME/autoload/netrw.vim
    let g:loaded_netrwFileHandlers  = 1 " $VIMRUNTIME/autoload/netrwFileHandlers.vim
    let g:loaded_netrwPlugin        = 1 " $VIMRUNTIME/plugin/netrwPlugin.vim
    let g:loaded_netrwSettings      = 1 " $VIMRUNTIME/autoload/netrwSettings.vim
    let g:loaded_rrhelper           = 1 " $VIMRUNTIME/plugin/rrhelper.vim
    let g:loaded_spellfile_plugin   = 1 " $VIMRUNTIME/plugin/spellfile.vim
    let g:loaded_sql_completion     = 1 " $VIMRUNTIME/autoload/sqlcomplete.vim
    let g:loaded_syntax_completion  = 1 " $VIMRUNTIME/autoload/syntaxcomplete.vim
    let g:loaded_tar                = 1 " $VIMRUNTIME/autoload/tar.vim
    let g:loaded_tarPlugin          = 1 " $VIMRUNTIME/plugin/tarPlugin.vim
    let g:loaded_tutor_mode_plugin  = 1 " $VIMRUNTIME/plugin/tutor.vim
    let g:loaded_vimball            = 1 " $VIMRUNTIME/autoload/vimball.vim
    let g:loaded_vimballPlugin      = 1 " $VIMRUNTIME/plugin/vimballPlugin
    let g:loaded_zip                = 1 " $VIMRUNTIME/autoload/zip.vim
    let g:loaded_zipPlugin          = 1 " $VIMRUNTIME/plugin/zipPlugin.vim
    let g:myscriptsfile             = 1 " $VIMRUNTIME/scripts.vim
    let g:netrw_nogx                = 1
    let g:suppress_doxygen          = 1 " $VIMRUNTIME/syntax/doxygen.vim

" }}} Plugins to be ignored
