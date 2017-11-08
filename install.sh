#!/usr/bin/env bash

# Name:     ys-vim: sensible vim and neovim configuration
# Desc:     My custom config for Vim8 and NeoVim, partly referred to ashfinal/vimrc-config, statico/dotfiles and liuchengxu/space-vim.
# Author:   corenel <xxdsox@gmail.com>
# URL:      https://github.com/corenel/ysvim
# License:  MIT license

set -e

# General Settings
YSVIM_NAME="ysvim"
YSVIM_HOME="$HOME/.ysvim"
YSVIM_CFG="$HOME/.ysvimrc"
YSVIM_URL="git@github.com:corenel/ysvim.git"

YSVIM_PLUG=1
YSVIM_DEIN=0
YSVIM_PATHOGEN=0

VIM_HOME="$HOME/.vim"
VIM_CFG="$HOME/.vimrc"
NVIM_HOME="$HOME/.config/nvim"
NVIM_CFG="$HOME/.config/nvim/init.vim"

# Custom Functions
exists() {
  which $1 >/dev/null 2>&1
}

check() {
  # check if command exists
  if ! exists $1 ; then
    echo "Error: $1 is not installed"
    exit 1
  fi
}

update_repo() {
  # clone or update git repo
  if [ -d $YSVIM_HOME/.git ]; then
    echo "Updating dotfiles using existing git..."
    cd $YSVIM_HOME
    git pull --quiet --rebase origin master
  else
    echo "Checking out dotfiles using git..."
    rm -rf $YSVIM_HOME
    git clone --quiet --depth=1 $YSVIM_URL $YSVIM_HOME
  fi
}

clean() {
  # bakcup file or directory
  dst=$1
  if [ -e $dst ]; then
    # Rename files with a ".old" extension.
    echo "$dst already exists, renaming to $dst.old"
    backup=$dst.old
    if [ -e $backup ]; then
      echo "Error: $backup already exists. Please delete or rename it."
      exit 1
    fi
    mv -v $dst $backup
  fi
}

init_config() {
  if [[ ! -e $YSVIM_CFG ]]; then
    cp $YSVIM_HOME/.ysvimrc.example $YSVIM_CFG
  fi
}

install_plugins() {
  if [[ $1 == "vim" ]]; then
    INS_HOME=$VIM_HOME
  elif [[ $1 == "nvim" ]]; then
    INS_HOME=$NVIM_HOME
  else
    echo "not set vim or nvim"
    exit 1
  fi

  if [[ $YSVIM_PLUG -eq 1 ]]; then
    # install Vim-Plug
    curl -LSso "$INS_HOME/autoload/plug.vim" --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    mkdir -p $INS_HOME/plugged
  elif [[ $YSVIM_DEIN -eq 1 ]]; then
    # install Dein.vim
    git clone https://github.com/Shougo/dein.vim $INS_HOME/dein/repos/github.com/Shougo/dein.vim
  elif [[ $YSVIM_PATHOGEN -eq 1 ]]; then
    # install pathogen
    curl -LSso $INS_HOME/autoload/pathogen.vim --create-dirs \
      https://tpo.pe/pathogen.vim
    # install plugins
    mkdir -p $INS_HOME/bundle
  else
    echo "No chosen plugin manager."
  fi
}

install_for_vim() {
  # clean old things
  clean $VIM_HOME
  clean $VIM_CFG
  mkdir -p $VIM_HOME

  # symbol link
  ln -sf "$YSVIM_HOME/init.vim" $VIM_CFG

  install_plugins "vim"
}

install_for_nvim() {
  # clean old things
  clean $NVIM_HOME
  clean $NVIM_CFG
  mkdir -p $NVIM_HOME

  # symbol link
  ln -sf "$YSVIM_HOME/init.vim" $NVIM_CFG

  # install plug
  install_plugins "nvim"
}

install() {
  if [[ check "vim" && check "nvim" ]] ; then
    echo "Find both 'vim' and 'nvim' in your system"
    while true; do
      echo "Install $YSVIM_NAME for:\n\t[0]vim\n\t[1]nvim\n\t[2]both vim and nvim"
      read -r -p "(Choose 0, 1 or 2):" opt
      case $opt in
        0)
          install_for_vim
          break
          ;;
        1)
          install_for_nvim
          break
          ;;
        2)
          install_for_vim
          install_for_nvim
          break
          ;;
        *)
          echo "Please choose 0, 1 or 2"
          ;;
      esac
    done
  elif exists "vim"; then
      echo "Find 'vim' in your system"
      echo "Starting to install $YSVIM_NAME for 'vim'"
      install_for_vim
  elif exists "nvim"; then
      echo "Find 'nvim' in your system"
      echo "Starting to install $YSVIM_NAME for 'nvim'"
      install_for_neovim
  else
      echo "You must have 'vim' or 'nvim' installed to continue"
      exit 1
  fi
}

# Main
check "git"
update_repo
init_config
install
echo "$YSVIM_NAME installed successfully!"
