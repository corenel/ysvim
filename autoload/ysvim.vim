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

    " Use Dein.vim
    let g:ysvim_dein_enable = 1
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
        if g:ysvim_dein_enable ==# 1
            call ysvim#util#check_dein(g:ysvim_dein_vim_dir)
            call ysvim#plugin#load_dein()
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
        call ysvim#util#load_basic_config()

        " Load user custom config
        try
            call CustomConfig()
        catch /.*/
            call ysvim#util#err('Error occurs in CustomConfig() in .ysvimrc!')
            echoerr v:exception
        endtry
    endfunction

" }}} End


