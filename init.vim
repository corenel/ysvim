" Name:     ys-vim: sensible vim and neovim configuration
" Desc:     My custom config for Vim8 and NeoVim, partly referred to ashfinal/vimrc-config, statico/dotfiles and liuchengxu/space-vim.
" Author:   corenel <xxdsox@gmail.com>
" URL:      https://github.com/corenel/ysvim
" License:  MIT license

" Platform-specific Initialization {{{

    let g:ysvim_macos = has('macunix')
    let g:ysvim_linux = has('unix') && !has('macunix') && !has('win32unix')
    let g:ysvim_windows= has('win32') || has('win64')

    if g:ysvim_windows
        echo 'Not tested on Windows.'
        set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    endif

" }}} Platform-specific Initialization

" Global Setiings {{{

    let g:ysvim_home = $HOME . '/.ysvim'
    let g:ysvim_version = '0.1.0'
    lockvar g:ysvim_version

    set runtimepath+=g:ysvim_home

" }}} Global Setiings

" Load Configurations and Plugins {{{

    call ysvim#begin()
    call ysvim#end()

" }}} Load Configurations and Plugins
