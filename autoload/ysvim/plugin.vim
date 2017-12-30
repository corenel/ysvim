" Name:     ys-vim: sensible vim and neovim configuration
" Desc:     My custom config for NeoVim, partly referred to ashfinal/vimrc-config, statico/dotfiles and liuchengxu/space-vim.
" Author:   corenel <xxdsox@gmail.com>
" URL:      https://github.com/corenel/ysvim
" License:  MIT license

scriptencoding utf8

" Dein Hook Function {{{

  " Deoplete {{{

    function! DeopleteHookFunc()
        call deoplete#custom#set('_', 'converters', ['converter_auto_paren', 'converter_remove_overlap'])
        call deoplete#custom#set('_', 'min_pattern_length', 1)
        call deoplete#custom#set('buffer', 'rank', 100)
        call deoplete#custom#set('go', 'matchers', ['matcher_fuzzy'])
        call deoplete#custom#set('go', 'sorters', [])
        call deoplete#custom#set('jedi', 'disabled_syntaxes', ['Comment'])
        call deoplete#custom#set('jedi', 'matchers', ['matcher_fuzzy'])
        call deoplete#custom#set('neosnippet', 'disabled_syntaxes', ['goComment'])"
        call deoplete#custom#set('ternjs', 'rank', 0)
        call deoplete#custom#set('vim', 'disabled_syntaxes', ['Comment'])
    endfunction

  " }}} Deoplete

  " Denite {{{

    function! DeniteHookFunc()
        " Change file_rec command.
        call denite#custom#var('file_rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
        " For ripgrep
        " Note: It is slower than ag
        call denite#custom#var('file_rec', 'command',
        \ ['rg', '--files', '--glob', '!.git'])
        " For Pt(the platinum searcher)
        " NOTE: It also supports windows.
        call denite#custom#var('file_rec', 'command',
        \ ['pt', '--follow', '--nocolor', '--nogroup',
        \  (has('win32') ? '-g:' : '-g='), ''])
        "For python script scantree.py (works if python 3.5+ in path)
        "Read bellow on this file to learn more about scantree.py
        call denite#custom#var('file_rec', 'command', ['scantree.py'])

        " Change mappings.
        call denite#custom#map(
              \ 'insert',
              \ '<C-j>',
              \ '<denite:move_to_next_line>',
              \ 'noremap'
              \)
        call denite#custom#map(
              \ 'insert',
              \ '<C-k>',
              \ '<denite:move_to_previous_line>',
              \ 'noremap'
              \)

        " Change matchers.
        call denite#custom#source(
        \ 'file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
        call denite#custom#source(
        \ 'file_rec', 'matchers', ['matcher_cpsm'])

        " Change sorters.
        call denite#custom#source(
        \ 'file_rec', 'sorters', ['sorter_sublime'])

        " Add custom menus
        let s:menus = {}

        let s:menus.zsh = {
          \ 'description': 'Edit your import zsh configuration'
          \ }
        let s:menus.zsh.file_candidates = [
          \ ['zshrc', '~/.config/zsh/.zshrc'],
          \ ['zshenv', '~/.zshenv'],
          \ ]

        let s:menus.my_commands = {
          \ 'description': 'Example commands'
          \ }
        let s:menus.my_commands.command_candidates = [
          \ ['Split the window', 'vnew'],
          \ ['Open zsh menu', 'Denite menu:zsh'],
          \ ]

        call denite#custom#var('menu', 'menus', s:menus)

        " Ag command on grep source
        call denite#custom#var('grep', 'command', ['ag'])
        call denite#custom#var('grep', 'default_opts',
            \ ['-i', '--vimgrep'])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'pattern_opt', [])
        call denite#custom#var('grep', 'separator', ['--'])
        call denite#custom#var('grep', 'final_opts', [])

        " Ack command on grep source
        call denite#custom#var('grep', 'command', ['ack'])
        call denite#custom#var('grep', 'default_opts',
            \ ['--ackrc', $HOME.'/.ackrc', '-H',
            \  '--nopager', '--nocolor', '--nogroup', '--column'])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'pattern_opt', ['--match'])
        call denite#custom#var('grep', 'separator', ['--'])
        call denite#custom#var('grep', 'final_opts', [])

        " Ripgrep command on grep source
        call denite#custom#var('grep', 'command', ['rg'])
        call denite#custom#var('grep', 'default_opts',
            \ ['--vimgrep', '--no-heading'])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
        call denite#custom#var('grep', 'separator', ['--'])
        call denite#custom#var('grep', 'final_opts', [])

        " Pt command on grep source
        call denite#custom#var('grep', 'command', ['pt'])
        call denite#custom#var('grep', 'default_opts',
            \ ['--nogroup', '--nocolor', '--smart-case'])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'pattern_opt', [])
        call denite#custom#var('grep', 'separator', ['--'])
        call denite#custom#var('grep', 'final_opts', [])

        " jvgrep command on grep source
        call denite#custom#var('grep', 'command', ['jvgrep'])
        call denite#custom#var('grep', 'default_opts', [])
        call denite#custom#var('grep', 'recursive_opts', ['-R'])
        call denite#custom#var('grep', 'pattern_opt', [])
        call denite#custom#var('grep', 'separator', [])
        call denite#custom#var('grep', 'final_opts', [])

        " Define alias
        call denite#custom#alias('source', 'file_rec/git', 'file_rec')
        call denite#custom#var('file_rec/git', 'command',
              \ ['git', 'ls-files', '-co', '--exclude-standard'])

        call denite#custom#alias('source', 'file_rec/py', 'file_rec')
        call denite#custom#var('file_rec/py', 'command',['scantree.py'])

        " Change default prompt
        call denite#custom#option('default', 'prompt', '>')

        " Change ignore_globs
        call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
              \ [ '.git/', '.ropeproject/', '__pycache__/',
              \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

        " Custom action
        call denite#custom#action('file', 'test',
              \ {context -> execute('let g:foo = 1')})
        call denite#custom#action('file', 'test2',
              \ {context -> denite#do_action(
              \  context, 'open', context['targets'])})

        " for feature use
        let g:cpsm_highlight_mode = 'detailed'
        let g:cpsm_match_empty_query = 0
        let g:cpsm_max_threads = 9
        let g:cpsm_query_inverting_delimiter = ''
        let g:ctrlp_match_current_file = 0
        let g:cpsm_unicode = 1
    endfunction

  " }}} Denite

  " Gina {{{

    function! GinaHookFunc()
        call gina#custom#command#option('commit', '-S|--signoff')
        call gina#custom#execute(
              \ '/\%(commit\)',
              \ 'setlocal colorcolumn=69 expandtab shiftwidth=2 softtabstop=2 tabstop=2 winheight=35',
              \)
        call gina#custom#execute(
              \ '/\%(status\|branch\|ls\|grep\|changes\|tag\)',
              \ 'setlocal winfixheight',
              \)
        call gina#custom#mapping#nmap(
              \ '/\%(commit\|status\|branch\|ls\|grep\|changes\|tag\)',
              \ 'q', ':<C-u> q<CR>', {'noremap': 1, 'silent': 1},
              \)
    endfunction

  " }}} Gina

  " Vimtex {{{

    function! VimtexHookFunc()
        " Config for Deoplete.vim
        if !exists('g:deoplete#omni#input_patterns')
            let g:deoplete#omni#input_patterns = {}
        endif
        let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
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
                    call dein#add('ryanoasis/vim-devicons')

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
                    call dein#add('lambdalisue/gina.vim', {'on_cmd': 'Gina', 'hook_source': "call GinaHookFunc()"})
                    call dein#add('airblade/vim-gitgutter')

                    " File Manager:
                    " call dein#add('scrooloose/nerdtree')
                    " call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
                    call dein#add('cocopon/vaffle.vim')

                    " Tmux:
                    " Plug 'benmills/vimux'
                    call dein#add('christoomey/vim-tmux-navigator')
                    call dein#add('roxma/vim-tmux-clipboard')

                    " Linter Formatter:
                    " call dein#add('neomake/neomake')
                    call dein#add('w0rp/ale')
                    call dein#add('sbdchd/neoformat', {'on_cmd': 'Neoformat'})

                    " Editing:
                    call dein#add('terryma/vim-multiple-cursors', {'on_map': {'n': ['<C-n>', '<C-p>'], 'x': '<C-n>'}})
                    call dein#add('haya14busa/vim-asterisk', {'on_map': '<Plug>'})
                    " call dein#add('tyru/caw.vim')
                    call dein#add('tpope/vim-commentary')
                    call dein#add('tpope/vim-repeat', {'on_map' : '.'})
                    call dein#add('tpope/vim-surround', {'on_map': {'n' : ['cs', 'ds', 'ys'], 'x' : 'S'}, 'depends' : 'vim-repeat'})
                    call dein#add('roxma/vim-paste-easy')
                    call dein#add('itchyny/vim-parenmatch', {'on_event': 'VimEnter'})

                    " Utils:
                    call dein#add('thinca/vim-quickrun', {'on_cmd': 'QuickRun'})
                    call dein#add('majutsushi/tagbar')
                    call dein#add('haya14busa/dein-command.vim', {'on_cmd': 'Dein'})
                    call dein#add('mattn/sonictemplate-vim', {'on_cmd': 'Template'})
                    call dein#add('tyru/open-browser.vim')
                    call dein#add('tyru/open-browser-github.vim', {'on_cmd': ['OpenGithubFile', 'OpenGithubIssue', 'OpenGithubPullReq']})
                    call dein#add('rhysd/accelerated-jk', {'on_map': '<Plug>'})
                    call dein#add('mbbill/undotree')

                    " Denite:
                    call dein#add('Shougo/denite.nvim', {'hook_add': 'call DeniteHookFunc()'})
                    "" Dependency:
                    call dein#add('nixprime/cpsm')
                    "" Denite Suorces:

                " }}} Enhancement

                " Intellisense {{{

                    " Deoplete:
                    call dein#add('Shougo/deoplete.nvim', {'hook_add': "call DeopleteHookFunc()"})
                    "" Deoplete Suorces:
                    call dein#add('Shougo/neco-vim', {'on_ft': ['vim'], 'on_source': ['deoplete.nvim']})
                    call dein#add('Shougo/neoinclude.vim', {'on_ft': ['c', 'cpp', 'objc', 'objcpp'], 'on_source': ['deoplete.nvim']})
                    call dein#add('Shougo/neosnippet-snippets')
                    call dein#add('honza/vim-snippets')
                    call dein#add('Shougo/neosnippet.vim', {'depends': ['neosnippet-snippets']})
                    call dein#add('zchee/deoplete-jedi', {'on_ft': ['python', 'cython', 'pyrex']})
                    call dein#add('zchee/deoplete-clang', {'on_ft': ['c', 'cpp', 'objc', 'objcpp']})
                    call dein#add('zchee/deoplete-docker', {'on_ft': ['dockerfile']})
                    call dein#add('zchee/deoplete-zsh', {'on_ft': ['sh', 'zsh']})
                    "" Deoplete Support:
                    call dein#add('Shougo/echodoc.vim', {'on_event': 'CompleteDone', 'hook_source': 'call echodoc#enable()'})
                    call dein#add('Shougo/neopairs.vim', {'on_event': 'CompleteDone', 'hook_add': 'let g:neopairs#enable = 1'})

                    " Language Plugin:
                    "" C Family:
                    call dein#add('vim-jp/vim-cpp', {'on_ft': ['c', 'cpp', 'objc']})
                    call dein#add('octol/vim-cpp-enhanced-highlight', {'on_ft': ['c', 'cpp', 'objc']})
                    call dein#add('lyuts/vim-rtags', {'on_ft': ['c', 'cpp', 'objc']})
                    call dein#add('CoatiSoftware/vim-coati', {'on_ft': ['c', 'cpp', 'objc']})

                    "" Python:
                    call dein#add('davidhalter/jedi-vim', {'lazy': 1, 'on_ft': ['python', 'cython', 'pyrex']})
                    call dein#add('hynek/vim-python-pep8-indent', {'on_ft': ['python', 'cython', 'pyrex']})
                    call dein#add('nvie/vim-flake8', {'on_ft': ['python', 'cython', 'pyrex']})
                    call dein#add('tweekmonster/impsort.vim', {'on_ft': ['python','cython', 'pyrex']})

                    "" TypeScript:
                    " call dein#add('leafgarland/typescript-vim', {'on_ft': 'typescript'})
                    " call dein#add('HerringtonDarkholme/yats.vim', {'on_ft': 'typescript'})

                    "" Javascript:
                    " call dein#add('othree/yajs.vim', {'on_ft': 'javascript'})

                    "" Markdown:
                    call dein#add('moorereason/vim-markdownfmt', {'on_ft': 'markdown'})
                    call dein#add('rhysd/vim-gfm-syntax', {'on_ft': 'markdown'})

                    "" Vim:
                    call dein#add('vim-jp/vimdoc-ja', {'on_ft': 'vim'})
                    call dein#add('vim-jp/syntax-vim-ex', {'on_ft': 'vim'})

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
