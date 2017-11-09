" Name:     ys-vim: sensible vim and neovim configuration
" Desc:     My custom config for Vim8 and NeoVim, partly referred to ashfinal/vimrc-config, statico/dotfiles and liuchengxu/space-vim.
" Author:   corenel <xxdsox@gmail.com>
" URL:      https://github.com/corenel/ysvim
" License:  MIT license

scriptencoding utf8

" Plugin Settings {{{

    " Appearance {{{

        " Lightline {{{

        if g:ysvim_vim8 || g:ysvim_nvim
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

        " startify {{{

        if g:ysvim_vim8 || g:ysvim_nvim
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

    " }}} Appearance

    " Enhancement {{{

        " fzf {{{

        if g:ysvim_vim8 || g:ysvim_nvim
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

        if g:ysvim_vim8 || g:ysvim_nvim
            " Tell ack.vim to use ag (the Silver Searcher) instead
            let g:ackprg = 'ag --vimgrep'
        endif

        " }}} ack.vim

        " GitGutter {{{

        if g:ysvim_vim8 || g:ysvim_nvim
            " Styling to use · instead of +/-
            let g:gitgutter_sign_added = '∙'
            let g:gitgutter_sign_modified = '∙'
            let g:gitgutter_sign_removed = '∙'
            let g:gitgutter_sign_modified_removed = '∙'
        endif

        " }}} GitGutter

        " " SuperTab {{{

        " if g:ysvim_vim8 || g:ysvim_nvim
        "     let g:SuperTabLongestEnhanced=1
        "     let g:SuperTabLongestHighlight=1
        " endif

        " " }}} SuperTab

        " incsearch.vim {{{

        if g:ysvim_vim8 || g:ysvim_nvim
            " Highlight as I search
            map /  <Plug>(incsearch-forward)
            map ?  <Plug>(incsearch-backward)
            map g/ <Plug>(incsearch-stay)
        endif

        " }}} incsearch.vim

        " undotree {{{

        if g:ysvim_vim8 || g:ysvim_nvim
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

        if g:ysvim_vim8 || g:ysvim_nvim
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

        if g:ysvim_vim8 || g:ysvim_nvim
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

        " " easymotion {{{

        " if g:ysvim_vim8 || g:ysvim_nvim
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

        if g:ysvim_vim8 || g:ysvim_nvim
            nmap \s :TagbarToggle<CR>
        endif

        " }}} tagbar

        " vimux {{{

        if g:ysvim_vim8 || g:ysvim_nvim
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

    " }}} Enhancement

    " Intellisense {{{

        " ALE {{{

        if g:ysvim_vim8 || g:ysvim_nvim
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

        " completor.vim {{{

        if g:ysvim_vim8
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

        " nvim-completion-manager {{{

        if g:ysvim_nvim
            " don't give |ins-completion-menu| messages.  For example,
            " " '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
            set shortmess+=c
            " When the <Enter> key is pressed while the popup menu is visible, it only hides the menu.
            " Use this mapping to hide the menu and also start a new line.
            inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
            " Here is an example for expanding snippet in the popup menu with <Enter> key. Suppose you
            " use the <C-U> key for expanding snippet.
            imap <expr> <CR>  (pumvisible() ?  "\<c-y>\<Plug>(expand_or_nl)" : "\<CR>")
            imap <expr> <Plug>(expand_or_nl) (cm#completed_is_snippet() ? "\<C-U>":"\<CR>")
            " When using CTRL-C key to leave insert mode, it does not trigger the autocmd InsertLeave.
            " You should use CTRL-[, or map the <c-c> to <ESC>.
            inoremap <c-c> <ESC>
            " Use <TAB> to select the popup menu:
            inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
            inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"\

            " settings for ultisnips
            let g:ultisnipsexpandtrigger            = '<plug>(ultisnips_expand)'
            let g:UltiSnipsJumpForwardTrigger       = '<c-j>'
            let g:UltiSnipsJumpBackwardTrigger      = '<c-k>'
            let g:UltiSnipsRemoveSelectModeMappings = 0
            inoremap <silent> <c-u> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>

            " If 'omnifunc' is the only available option, you may register it as a source for NCM.
            augroup custom_cm_setup
                autocmd!
                autocmd User CmSetup call cm#register_source({
                    \ 'name' : 'vimtex',
                    \ 'priority': 8,
                    \ 'scoping': 1,
                    \ 'scopes': ['tex'],
                    \ 'abbreviation': 'tex',
                    \ 'cm_refresh_patterns': g:vimtex#re#ncm,
                    \ 'cm_refresh': {'omnifunc': 'vimtex#complete#omnifunc'},
                    \ })
            augroup END
        endif

        " }}} nvim-completion-manager

        " " vim-cpp-enhanced-highlight {{{

        " if g:ysvim_vim8 || g:ysvim_nvim
        "     let g:cpp_class_scope_highlight = 1
        "     let g:c_no_curly_error=1
        " endif

        " " }}} vim-cpp-enhanced-highlight

        " vim-autoformat {{{

        if g:ysvim_vim8 || g:ysvim_nvim
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

        " python-mode {{{

        if g:ysvim_vim8 || g:ysvim_nvim
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

    " }}} Intellisense

    " Feature {{{

        " vimtex {{{

        if g:ysvim_vim8 || g:ysvim_nvim
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

        " vim-orgmode {{{

        if g:ysvim_vim8 || g:ysvim_nvim
            let g:org_todo_keywords = ['TODO', 'NEXT', '|', 'DONE']
        endif

        " }}} vim-orgmode

    " }}} Feature

" }}} Plugin Settings
