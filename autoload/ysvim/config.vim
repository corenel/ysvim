" Name:     ys-vim: sensible vim and neovim configuration
" Desc:     My custom config for Vim8 and NeoVim, partly referred to ashfinal/vimrc-config, statico/dotfiles and liuchengxu/space-vim.
" Author:   corenel <xxdsox@gmail.com>
" URL:      https://github.com/corenel/ysvim
" License:  MIT license

scriptencoding utf8

" Plugin Hook Functions {{{

    " Appearance {{{

        " Lightline.vim {{{

        function! ysvim#config#lightline_vim()
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
        endfunction

        " }}} Lightline.vim

        " vim-startify {{{

        function! ysvim#config#vim_startify()
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
        endfunction

        " }}} vim-startify

        " vim-devicons {{{

        function! ysvim#config#vim_devicons()
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
        endfunction

        " }}} vim-devicons

    " }}} Appearance

    " Enhancement {{{

        " undotree {{{

        function! ysvim#config#undotree()
            let g:undotree_SplitWidth = 40
            let g:undotree_SetFocusWhenToggle = 1
            nmap <silent> <Leader>u :UndotreeToggle<CR>

            call ysvim#util#check_dir(g:ysvim_cache . '/undotree')
            if has('persistent_undo')
                let &undodir = g:ysvim_cache . '/undotree'
                set undofile
            endif
        endfunction

        " }}} undotree

        " vim-multiple-cursors {{{

        function! ysvim#config#vim_multiple_cursors()
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
        endfunction
        " }}} vim-multiple-cursors

        " tagbar {{{

        function! ysvim#config#tagbar()
            nmap \s :TagbarToggle<CR>
            " The tags are not sorted according to their name
            let g:tagbar_sort = 0
        endfunction

        " }}} tagbar

        " vim-tmux-navigator {{{

        function! ysvim#config#vim_tmux_navigator()
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
        endfunction

        " }}} vim-tmux-navigator

        " NerdTree {{{

        function! ysvim#config#nerdtree()
            let g:NERDTreeQuitOnOpen=1
        endfunction

        " }}} NerdTree

        " vim-nerdtree-syntax-highlight {{{

        function! ysvim#config#nerdtree_syntax_highlight()
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
        endfunction

        " }}} vim-nerdtree-syntax-highlight

    " }}} Enhancement

    " Intellisense {{{

        " python-mode {{{

        function! ysvim#config#python_mode()
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
        endfunction

        " }}} python-mode

        " vimtex {{{

        function! ysvim#config#vimtex()
            let g:polyglot_disabled = ['latex']

            "tex preview config
            let g:texflavor = 'latex'
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
        endfunction

        " }}} vimtex

        " jedi.vim {{{

        function! ysvim#config#jedi_vim()
            " don't initialize
            " let g:jedi#auto_initialization = 0
            let g:jedi#auto_vim_configuration = 0
            " let g:jedi#show_call_signatures = 0

            let g:jedi#force_py_version = 3

            " key bindings
            let g:jedi#goto_command = '<leader>jc'
            let g:jedi#goto_assignments_command = '<leader>jg'
            let g:jedi#goto_definitions_command = '<leader>jd'
            let g:jedi#documentation_command = '<leader>jk'
            let g:jedi#usages_command = '<leader>jn'
            let g:jedi#completions_command = '<C-Space>'
            let g:jedi#rename_command = '<leader>jr'
        endfunction

        " }}} jedi.vim

    " }}} Intellisense

" }}} Plugin Settings
