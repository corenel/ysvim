" Name:     ys-vim: sensible vim and neovim configuration
" Desc:     My custom config for Vim8 and NeoVim, partly referred to ashfinal/vimrc-config, statico/dotfiles and liuchengxu/space-vim.
" Author:   corenel <xxdsox@gmail.com>
" URL:      https://github.com/corenel/ysvim
" License:  MIT license

scriptencoding utf8

" Plugin Settings {{{

    " Vim-Plug {{{

        nnoremap <Leader>pi :PlugInstall<CR>
        nnoremap <Leader>pu :PlugUpdate<CR>

    " }}} Vim-Plug

    " Appearance {{{

        " Lightline.vim {{{

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
        endif

        " }}} Lightline.vim

        " vim-startify {{{

        if g:ysvim_vim8 || g:ysvim_nvim
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
                \ {'o': '$HOME/Dropbox/Documents/Orgzly/'},
                \ {'w': '$HOME/Workspace/'},
                \ ]

            let g:startify_session_dir        = g:ysvim_home . '/.tmp/session'
            let g:startify_change_to_vcs_root = 1
            let g:startify_update_oldfiles    = 1
            let g:startify_change_to_dir      = 1
            let g:startify_files_number       = 8


            if g:colors_name ==# 'molokai'
                hi StartifyBracket ctermfg=240
                hi StartifyFile    ctermfg=147
                hi StartifyFooter  ctermfg=240
                hi StartifyHeader  ctermfg=114
                hi StartifyNumber  ctermfg=215
                hi StartifyPath    ctermfg=245
                hi StartifySlash   ctermfg=240
                hi StartifySpecial ctermfg=240
            endif
        endif

        " }}} vim-startify

        " vim-devicons {{{

        if g:ysvim_vim8 || g:ysvim_nvim
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
        endif

        " }}} vim-devicons

        " vim-nerdtree-syntax-highlight {{{

        if g:ysvim_vim8 || g:ysvim_nvim
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
        endif

        " }}} vim-nerdtree-syntax-highlight

    " }}} Appearance

    " Enhancement {{{

        " fzf {{{

        if g:ysvim_vim8 || g:ysvim_nvim
            " Replaces Ctrl-P, FuzzyFinder and Command-T
            set runtimepath+=/usr/local/opt/fzf
            set runtimepath+=~/.fzf
            nmap <Leader>fb :Buffers<CR>
            nmap <Leader>ft :Tags<CR>
            nmap <Leader>ff :Files<CR>
            nmap <Leader>fa :Ag<CR>
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
            " let g:gitgutter_sign_added = '∙'
            " let g:gitgutter_sign_modified = '∙'
            " let g:gitgutter_sign_removed = '∙'
            " let g:gitgutter_sign_modified_removed = '∙'
        endif

        " }}} GitGutter

        " gv.vim {{{

        if g:ysvim_vim8 || g:ysvim_nvim
            " open commit browser
            nnoremap <Leader>gv :GV<CR>
            " only list commits that affects the current file
            nnoremap <Leader>gh :GV!<CR>
        endif

        " }}} gv.vim

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

            call ysvim#util#check_dir(g:ysvim_home . '/.tmp/undotree')
            if has('persistent_undo')
                let &undodir = g:ysvim_home . '/.tmp/undotree'
                set undofile
            endif
        endif

        " }}} undotree

        " ultisnips {{{

        if g:ysvim_vim8 || g:ysvim_nvim
            " settings for ultisnips
            " let g:UltiSnipsExpandTrigger = '<Tab>'
            " let g:UltiSnipsJumpForwardTrigger = '<C-n>'
            " let g:UltiSnipsJumpBackwardTrigger = '<C-p>'
            " let g:UltiSnipsEditSplit = 'context'

            " set custom dir
            " let g:UltiSnipsSnippetDirectories=['UltiSnips']
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

        " " vimux {{{

        " if g:ysvim_vim8 || g:ysvim_nvim
        "     " Run the current file with python3
        "     augroup vimuxruncmd:
        "         autocmd!
        "         autocmd Filetype python nnoremap <buffer> <Leader>rr :update<Bar>:call VimuxRunCommandInDir("clear; python3 " . bufname("%"), 0)<CR>
        "     augroup END

        "     " Run REPL with python3
        "     map <Leader>rp :call VimuxRunCommand("clear; python3", 0)<CR>

        "     " Prompt for a command to run
        "     map <Leader>vp :VimuxPromptCommand<CR>

        "     " Run last command executed by VimuxRunCommand
        "     map <Leader>vl :VimuxRunLastCommand<CR>

        "     " Inspect runner pane
        "     map <Leader>vi :VimuxInspectRunner<CR>

        "     " Close vim tmux runner opened by VimuxRunCommand
        "     map <Leader>vq :VimuxCloseRunner<CR>

        "     " Interrupt any command running in the runner pane
        "     map <Leader>vx :VimuxInterruptRunner<CR>

        "     " Zoom the runner pane (use <bind-key> z to restore runner pane)
        "     map <Leader>vz :call VimuxZoomRunner()<CR>

        "     " Toggle pane
        "     map <Leader>vt :call VimuxTogglePane()<CR>

        "     " Always use vertical split pane
        "     let g:VimuxOrientation = 'v'

        "     " Always create new pane
        "     let g:VimuxUseNearest = 0

        "     " Vimux height percent
        "     let g:VimuxHeight = '20'
        " endif

        " " }}} vimux

        " vim-tmux-navigator {{{

        if g:ysvim_vim8 || g:ysvim_nvim
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
        endif

        " }}} vim-tmux-navigator

        " codi.vim {{{

        if g:ysvim_vim8 || g:ysvim_nvim
            let g:codi#interpreters = {
                \ 'python': {
                    \ 'bin': 'python3',
                    \ 'prompt': '^\(>>>\|\.\.\.\) ',
                    \ },
                \ }
            " activates Codi for the current buffer
            nnoremap <Leader>ca :Codi<CR>
            " toggles Codi for the current buffer
            nnoremap <Leader>cs :Codi!<CR>
            " deactivates Codi for the current buffer
            nnoremap <Leader>cd :Codi!<CR>
        endif

        " }}} codi.vim

        " tabular {{{

        if g:ysvim_vim8 || g:ysvim_nvim
            if exists(':Tabularize')
                " align =
                nmap <Leader>a= :Tabularize /=<CR>
                vmap <Leader>a= :Tabularize /=<CR>
                " align :
                nmap <Leader>a; :Tabularize /:\zs<CR>
                vmap <Leader>a; :Tabularize /:\zs<CR>
                " align |
                nmap <Leader>a| :Tabularize /|<CR>
                vmap <Leader>a| :Tabularize /|<CR>
            endif
        endif

        " }}} tabular

        " vim-table-mode {{{

        if g:ysvim_vim8 || g:ysvim_nvim
            let g:table_mode_corner='|'
        endif

        " }}} vim-table-mode

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
            " inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

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
            let g:UltiSnipsExpandTrigger            = '<plug>(ultisnips_expand)'
            let g:UltiSnipsJumpForwardTrigger       = '<c-j>'
            let g:UltiSnipsJumpBackwardTrigger      = '<c-k>'
            let g:UltiSnipsRemoveSelectModeMappings = 0
            inoremap <silent> <c-u> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>

            " Add preview to see docstrings in the complete window.
            " let g:cm_completeopt = 'menu,menuone,noinsert,noselect,preview'
            let g:cm_completeopt = 'menu,menuone,noinsert,noselect'

            " Close the prevew window automatically on InsertLeave
            " https://github.com/davidhalter/jedi-vim/blob/eba90e615d73020365d43495fca349e5a2d4f995/ftplugin/python/jedi.vim#L44
            augroup ncm_preview
                autocmd!
                autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
                " autocmd! InsertLeave <buffer> if pumvisible() == 0|pclose|endif
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
        endif


        " }}} python-mode

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

            " If 'omnifunc' is the only available option, you may register it as a source for NCM.
            augroup custom_cm_setup
                autocmd!
                if exists(':VimtexCompile')
                    autocmd User CmSetup call cm#register_source({
                        \ 'name' : 'vimtex',
                        \ 'priority': 8,
                        \ 'scoping': 1,
                        \ 'scopes': ['tex'],
                        \ 'abbreviation': 'tex',
                        \ 'cm_refresh_patterns': g:vimtex#re#ncm,
                        \ 'cm_refresh': {'omnifunc': 'vimtex#complete#omnifunc'},
                        \ })
                endif
            augroup END


        endif

        " }}} vimtex

        " vim-orgmode {{{

        if g:ysvim_vim8 || g:ysvim_nvim
            let g:org_todo_keywords = ['TODO', 'NEXT', '|', 'DONE']
        endif

        " }}} vim-orgmode

        " ncm-clang {{{

        if g:ysvim_nvim
            augroup ncm_clang_custom
                autocmd BufEnter *.cpp,*.h,*.hpp,*.hxx let g:ale_cpp_clang_options = join(ncm_clang#compilation_info()['args'], ' ')
            augroup END
        endif

        " }}} ncm-clang

        " clang-complete {{{

        if g:ysvim_vim8 || g:ysvim_nvim
            let g:clang_make_default_keymappings = 0
            let g:clang_auto_user_options = ''

            func! g:WrapClangGoTo()
                let cwd = getcwd()
                let info = ncm_clang#compilation_info()
                exec 'cd ' . info['directory']
                try
                    let b:clang_user_options = join(info['args'], ' ')
                    call g:ClangGotoDeclaration()
                catch
                endtry
                " restore
                exec 'cd ' . cwd
            endfunc

            augroup clang_complete_custom
                autocmd!
                autocmd FileType c,cpp nnoremap <buffer> gd :call WrapClangGoTo()<CR>
            augroup END
        endif

        " }}} clang-complete

        " vim-markdown {{{

        if g:ysvim_vim8 || g:ysvim_nvim
            let g:vim_markdown_initial_foldlevel=100
        endif

        " }}} vim-markdown

        " jedi.vim {{{

        if g:ysvim_vim8 || g:ysvim_nvim
            " don't initialize
            let g:jedi#auto_initialization = 0
            let g:jedi#auto_vim_configuration = 0
            let g:jedi#show_call_signatures = 0

            let g:jedi#force_py_version = 3

            " key bindings
            let g:jedi#goto_command = '<leader>jc'
            let g:jedi#goto_assignments_command = '<leader>jg'
            let g:jedi#goto_definitions_command = '<leader>jd'
            let g:jedi#documentation_command = '<leader>jk'
            let g:jedi#usages_command = '<leader>jn'
            let g:jedi#completions_command = '<C-Space>'
            let g:jedi#rename_command = '<leader>jr'
        endif

        " }}} jedi.vim

    " }}} Intellisense

" }}} Plugin Settings
