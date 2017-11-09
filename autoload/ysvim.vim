" Name:     ys-vim: sensible vim and neovim configuration
" Desc:     My custom config for Vim8 and NeoVim, partly referred to ashfinal/vimrc-config, statico/dotfiles and liuchengxu/space-vim.
" Author:   corenel <xxdsox@gmail.com>
" URL:      https://github.com/corenel/ysvim
" License:  MIT license

scriptencoding utf8

" Init {{{

    let g:ysvim_nvim = has('nvim') && exists('*jobwait') && !g:ysvim_windows
    let g:ysvim_vim8 = exists('*job_start')
    let g:ysvim_gui = has('gui_running')
    let g:ysvim_tmux = !empty($TMUX) 

    " Use Pathgon for plugin management.
    let g:ysvim_pathogen_enable = 0
    let g:ysvim_pathogen_home = g:ysvim_home . '/bundle'
    let g:ysvim_pathogen_vim = g:ysvim_pathogen_home . '/vim-pathogen/autoload/pathogen.vim'
    let g:ysvim_pathogen_vim_dir = g:ysvim_pathogen_home . '/vim-pathogen'

    " Use Vim-Plug
    let g:ysvim_plug_enable = 1
    let g:ysvim_plug_home = g:ysvim_home . '/plugged'
    let g:ysvim_plug_vim = g:ysvim_plug_home . '/plug.vim/vim-plug/plug.vim'
    let g:ysvim_plug_vim_dir = g:ysvim_plug_home . '/plug.vim/vim-plug'

    " Use Dein.vim
    let g:ysvim_dein_enable = 0
    let g:ysvim_dein_home = g:ysvim_home . '/dein'
    let g:ysvim_dein_vim = g:ysvim_dein_home . '/repos/github.com/Shougo/dein.vim/autoload/dein.vim'
    let g:ysvim_dein_vim_dir = g:ysvim_dein_home . '/repos/github.com/Shougo/dein.vim'

" }}} Init

" Begin {{{

    function! ysvim#begin() abort
        " Load .ysvimrc
        call ysvim#util#source_file(g:ysvim_config)

        " Download plugin manager if unavailable
        " Then use manager to load plugins
        if g:ysvim_plug_enable ==# 1
            call ysvim#util#check_vim_plug(g:ysvim_plug_vim)
            call ysvim#plugin#load_vim_plug()
        elseif g:ysvim_dein_enable ==# 1
            call ysvim#util#check_dein(g:ysvim_plug_vim_dir)
            call ysvim#plugin#load_dein()
        elseif g:ysvim_pathogen_enable ==# 1
            call ysvim#util#check_pathogen(g:ysvim_pathogen_vim)
            call ysvim#plugin#load_pathogen()
        endif

        try
            call CustomInit()
        catch
            call ysvim#util#err('Error occurs in CustomInit() in .ysvimrc!')
        endtry
    endfunction

" }}} Begin

" End {{{

    function! ysvim#end()
        " Load basic config and plugin settings
        call ysvim#util#load_config()

        " Load user custom config
        try
            call CustomConfig()
        catch /.*/
            call ysvim#util#err('Error occurs in CustomConfig() in .ysvimrc!')
            echoerr v:exception
        endtry

        " Some plugin seems to search for something at startup, so this fixes that.
        silent! nohlsearch

        " vim:set tw=100:
    endfunction

" }}} End


