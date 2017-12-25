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
    endif

    " Specify python host path
    if g:ysvim_macos
        let g:python_host_prog  = '/usr/local/bin/python2'
        let g:python3_host_prog = '/usr/local/bin/python3'
    elseif g:ysvim_linux
        if isdirectory('/home/linuxbrew/.linuxbrew/')
            let g:python_host_prog  = '/home/linuxbrew/.linuxbrew/bin/python2'
            let g:python3_host_prog = '/home/linuxbrew/.linuxbrew/bin/python3'
        else
            let g:python_host_prog  = '/usr/bin/python2'
            let g:python3_host_prog = '/usr/bin/python3'
        endif
    endif

" }}} Platform-specific Initialization

" Global Setiings {{{

    let g:ysvim_home = $HOME . '/.ysvim'
    let g:ysvim_cache = g:ysvim_home . '/cache'
    let g:ysvim_config = $HOME.'/.ysvimrc'
    let g:ysvim_version = '0.2.0'
    lockvar g:ysvim_version

    let &runtimepath .= &runtimepath . ',' . g:ysvim_home
    let &runtimepath .= &runtimepath . ',' . g:ysvim_home . '/after'

" }}} Global Setiings

" Load Configurations and Plugins {{{

    call ysvim#begin()
    call ysvim#end()

" }}} Load Configurations and Plugins
