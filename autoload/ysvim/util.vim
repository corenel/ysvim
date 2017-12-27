" Name:     ys-vim: sensible vim and neovim configuration
" Desc:     My custom config for NeoVim, partly referred to ashfinal/vimrc-config, statico/dotfiles and liuchengxu/space-vim.
" Author:   corenel <xxdsox@gmail.com>
" URL:      https://github.com/corenel/ysvim
" License:  MIT license

scriptencoding utf8

" Function {{{
function! ysvim#util#err(msg)
    echohl ErrorMsg
    echom '[ysvim] '. a:msg
    echohl None
endfunction

function! ysvim#util#warn(cmd, msg)
    echohl WarningMsg
    echom '[ysvim] '. a:msg
    echohl None
endfunction

function! ysvim#util#info(msg)
    echom '[ysvim] '. a:msg
endfunction

function! ysvim#util#check_vim_plug(plug_path)
    if empty(glob(a:plug_path))
        echo '==> Downloading Vim-Plug ......'
        execute '!curl -LSso ' . a:plug_path . ' --create-dirs ' .
            \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif
endfunction

function! ysvim#util#check_dein(dein_path)
    if &runtimepath !~ '/dein.vim'
        if !isdirectory(a:dein_path)
            echo '==> Downloading Dein.vim ......'
            call mkdir(fnamemodify(a:dein_path, ':h'), 'p')
            execute '!git clone https://github.com/Shougo/dein.vim' a:dein_path
        endif
    endif
endfunction

function! ysvim#util#check_pathogen(pathogen_path)
    if empty(glob(a:pathogen_path))
        echo '==> Downloading Pathogen ......'
        execute '!curl -LSso ' . a:pathogen_path . ' --create-dirs ' .
            \ 'https://tpo.pe/pathogen.vim'
    endif
endfunction

function! ysvim#util#load_basic_config()
    " Load basic config
    let l:ysvim_basic_config = g:ysvim_home . '/autoload/ysvim/basic.vim'
    call ysvim#util#source_file(l:ysvim_basic_config)
endfunction

function! ysvim#util#load_plugin_config()
    " Load basic config
    let l:ysvim_plugin_config = g:ysvim_home . '/autoload/ysvim/config.vim'
    call ysvim#util#source_file(l:ysvim_plugin_config)
endfunction

function! ysvim#util#source_file(filepath)
    if filereadable(expand(a:filepath))
        execute 'source ' . fnameescape(a:filepath)
    else
        call ysvim#util#err('file ' . a:filepath . ' does not exist!')
    endif
endfunction

function! ysvim#util#check_dir(dirpath)
    if !isdirectory(expand(a:dirpath))
        call mkdir(a:dirpath, 'p')
    endif
endfunction

function! ysvim#util#exists_file(filepath)
    if filereadable(expand(a:filepath))
        return 1
    else
        return 0
    endif
endfunction

" }}} Function

