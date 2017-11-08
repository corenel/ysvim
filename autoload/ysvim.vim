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

" }}} Init

" Plugin manager {{{

    " Use Pathgon for plugin management.
    let g:ysvim_pathogen_enable = 1
    let g:ysvim_pathogen_home = g:ysvim_home . '/bundle'
    let g:ysvim_pathogen_vim = g:ysvim_pathogen_home . '/vim-pathogen/autoload/pathogen.vim'

    " Use Vim-Plug
    let g:ysvim_plug_enable = 1
    let g:ysvim_plug_home = g:ysvim_home.'/plugged'
    let g:ysvim_plug_vim = g:ysvim_plug_home . '/plug.vim/vim-plug/plug.vim'
    let g:ysvim_plug_vim_dir = g:ysvim_plug_home . '/plug.vim/vim-plug'

    " Use Dein.vim
    let g:ysvim_dein_enable = 1
    let g:ysvim_dein_home = g:ysvim_home . '/dein'
    let g:ysvim_dein_vim = g:ysvim_dein_dir . '/repos/github.com/Shougo/dein.vim/autoload/dein.vim'
    let g:ysvim_dein_vim_dir = g:ysvim_dein_dir . '/repos/github.com/Shougo/dein.vim'

" }}} Plugin manager

" Filetype triggers {{{

" Reset all autocommands
augroup vimrc
    autocmd!
    au BufNewFile,BufRead *.cson    set ft=coffee
    au BufNewFile,BufRead *.glsl    setf glsl
    au BufNewFile,BufRead *.gyp     set ft=python
    au BufNewFile,BufRead *.html    setlocal nocindent smartindent
    au BufNewFile,BufRead *.i7x     setf inform7
    au BufNewFile,BufRead *.ini     setf conf
    au BufNewFile,BufRead *.input   setf gnuplot
    au BufNewFile,BufRead *.json    set ft=json tw=0
    au BufNewFile,BufRead *.less    setlocal ft=less nocindent smartindent
    au BufNewFile,BufRead *.md      setlocal ft=markdown nolist
    au BufNewFile,BufRead *.md,*.markdown setlocal foldlevel=999 tw=0 nocin
    au BufNewFile,BufRead *.ni      setlocal ft=inform nolist ts=2 sw=2 noet
    au BufNewFile,BufRead *.plist   setf xml
    au BufNewFile,BufRead *.rb      setlocal noai
    au BufNewFile,BufRead *.rxml    setf ruby
    au BufNewFile,BufRead *.sass    setf sass
    au BufNewFile,BufRead *.ttml    setf xml
    au BufNewFile,BufRead *.vert,*.frag set ft=glsl
    au BufNewFile,BufRead *.xml     setlocal ft=xml  ts=2 sw=2 et
    au BufNewFile,BufRead *.tex     setlocal tw=0 nocin
    au BufNewFile,BufRead *.zone    setlocal nolist ts=4 sw=4 noet
    au BufNewFile,BufRead *.zsh     setf zsh
    au BufNewFile,BufRead *templates/*.html setf htmldjango
    au BufNewFile,BufRead .git/config setlocal ft=gitconfig nolist ts=4 sw=4 noet
    au BufNewFile,BufRead .gitconfig* setlocal ft=gitconfig nolist ts=4 sw=4 noet
    au BufNewFile,BufRead .vimlocal,.gvimlocal setf vim
    au BufNewFile,BufRead .zsh.custom setf zsh
    au BufNewFile,BufRead /tmp/crontab* setf crontab
    au BufNewFile,BufRead COMMIT_EDITMSG setlocal nolist nonumber
    au BufNewFile,BufRead Makefile setlocal nolist
    au FileType gitcommit setlocal nolist ts=4 sts=4 sw=4 noet
    au FileType python setlocal tw=79
    au FileType inform7 setlocal nolist tw=0 ts=4 sw=4 noet foldlevel=999
    au FileType json setlocal conceallevel=0 foldmethod=syntax foldlevel=999
    au FileType make setlocal nolist ts=4 sts=4 sw=4 noet
    au FileType markdown syn sync fromstart
    au Filetype gitcommit setlocal tw=80
augroup END
" }}} Filetype triggers

" Post {{{

" Some plugin seems to search for something at startup, so this fixes that.
silent! nohlsearch

" vim:set tw=100:

" }}} Post
