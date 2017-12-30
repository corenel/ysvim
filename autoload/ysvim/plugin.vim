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
      call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>', 'noremap')
      call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>', 'noremap')

      call denite#custom#source('line', 'command', ['pt', '--nocolor', '--nogroup', '--follow', '--hidden', '-g', ''])

      call denite#custom#source('file_rec', 'matchers', ['matcher_cpsm'])
      call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])
      call denite#custom#var('file_rec', 'command', ['pt', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])
      call denite#custom#alias('source', 'file_rec/ag', 'file_rec')
      call denite#custom#var('file_rec/ag', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
      call denite#custom#alias('source', 'file_rec/rg', 'file_rec')
      call denite#custom#var('file_rec/rg', 'command', ['rg', '--files', '--glob', '!.git'])

      call denite#custom#var('grep', 'command', ['pt'])
      call denite#custom#var('grep', 'default_opts', ['--follow', '--hidden', '--nocolor', '--nogroup', '--ignore="_*"'])
      call denite#custom#var('grep', 'recursive_opts', [])
      call denite#custom#var('grep', 'pattern_opt', ['-e'])
      call denite#custom#var('grep', 'separator', [])
      call denite#custom#var('grep', 'final_opts', [])

      call denite#custom#alias('source', 'grep/rg', 'grep')
      call denite#custom#var('grep/rg', 'command', ['rg'])
      call denite#custom#var('grep/rg', 'default_opts', ['--vimgrep', '--no-heading'])
      call denite#custom#var('grep/rg', 'recursive_opts', [])
      call denite#custom#var('grep/rg', 'pattern_opt', ['--regexp'])
      call denite#custom#var('grep/rg', 'separator', ['--'])
      call denite#custom#var('grep/rg', 'final_opts', [])

      let s:menus = {}
      let s:menus.zsh = {'description': 'Edit your import zsh configuration'}
      let s:menus.zsh.file_candidates = [['~/.zshrc'], ['zshenv', '~/.zshenv']]
      call denite#custom#var('menu', 'menus', s:menus)

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
                    "" load nerdtree-git-plugin before VimDevIcons loads.
                    call dein#add('Xuyuanp/nerdtree-git-plugin')
                    call dein#add('ryanoasis/vim-devicons')

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
                    call dein#add('lambdalisue/gina.vim', {'on_cmd': 'Gina', 'hook_add': "call GinaHookFunc()"})
                    call dein#add('airblade/vim-gitgutter')


                    " NerdTree:
                    call dein#add('scrooloose/nerdtree')
                    call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')

                    " Tmux:
                    " Plug 'benmills/vimux'
                    call dein#add('christoomey/vim-tmux-navigator')

                    " Linter Formatter:
                    " call dein#add('neomake/neomake')
                    call dein#add('w0rp/ale')
                    call dein#add('sbdchd/neoformat', {'on_cmd': 'Neoformat'})

                    " Editing:
                    call dein#add('mbbill/undotree')
                    call dein#add('terryma/vim-multiple-cursors', {'on_map': {'n': ['<C-n>', '<C-p>'], 'x': '<C-n>'}})


                    call dein#add('tpope/vim-commentary')
                    call dein#add('tpope/vim-repeat', {'on_map' : '.'})
                    call dein#add('tpope/vim-surround', {'on_map': {'n' : ['cs', 'ds', 'ys'], 'x' : 'S'}, 'depends' : 'vim-repeat'})
                    call dein#add('roxma/vim-paste-easy')
                    call dein#add('roxma/vim-tmux-clipboard')
                    call dein#add('majutsushi/tagbar')

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

                    " Denite:
                    call dein#add('Shougo/denite.nvim', {'hook_add': "call DeniteHookFunc()"})
                    "" Dependency:
                    call dein#add('nixprime/cpsm')
                    "" Denite Suorces:

                    " Language Plugin:
                    "" C Family:
                    call dein#add('vim-jp/vim-cpp', {'on_ft': ['c', 'cpp', 'objc']})
                    call dein#add('octol/vim-cpp-enhanced-highlight', {'on_ft': ['c', 'cpp', 'objc']})
                    call dein#add('lyuts/vim-rtags', {'on_ft': ['c', 'cpp', 'objc']})
                    call dein#add('CoatiSoftware/vim-coati', {'on_ft': ['c', 'cpp', 'objc']})

                    "" Python:
                    call dein#add('davidhalter/jedi-vim', {'lazy': 1, 'on_ft': ['python', 'cython', 'pyrex']})
                    " call dein#add('hynek/vim-python-pep8-indent', {'on_ft': ['python', 'cython', 'pyrex']})
                    " call dein#add('nvie/vim-flake8', {'on_ft': ['python', 'cython', 'pyrex']})
                    " call dein#add('tweekmonster/impsort.vim', {'on_ft': ['python','cython', 'pyrex']})

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

" }}} Plugin List


