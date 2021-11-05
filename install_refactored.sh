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
YSVIM_CFG="$YSVIM_HOME/.vimrc"
YSVIM_URL="https://github.com/corenel/ysvim.git"
YSVIM_BRANCH="refactor"

VIM_HOME="$HOME/.vim"
VIM_CFG="$HOME/.vimrc"
NVIM_HOME="$HOME/.config/nvim"
NVIM_CFG="$HOME/.config/nvim/init.vim"

# Custom Functions
exists() {
  command -v "$1" >/dev/null 2>&1
}

check() {
  # check if command exists
  if ! exists "$1" ; then
    echo "Error: $1 is not installed"
    exit 1
  fi
}

update_repo() {
  # clone or update git repo
  if [ -d $YSVIM_HOME/.git ]; then
    echo "Updating dotfiles using existing git..."
    cd "$YSVIM_HOME"
    git pull --quiet --rebase origin ${YSVIM_BRANCH}
  else
    echo "Checking out dotfiles using git..."
    rm -rf "$YSVIM_HOME"
    git clone --quiet --depth=1 -b ${YSVIM_BRANCH} "$YSVIM_URL" "$YSVIM_HOME"
    mkdir -p $YSVIM_HOME/files/info
    touch $YSVIM_HOME/files/info/viminfo
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
    mv -v "$dst" "$backup"
  fi
}

install_for_vim() {
  # clean old things
  clean "$VIM_HOME"
  clean "$VIM_CFG"
  mkdir -p "$VIM_HOME"

  # symbol link
  ln -sf "$YSVIM_CFG" "$VIM_CFG"
}

install_for_nvim() {
  # clean old things
  clean "$NVIM_HOME"
  clean "$NVIM_CFG"
  mkdir -p "$NVIM_HOME"

  # symbol link
  ln -sf "$YSVIM_CFG" "$NVIM_CFG"
}

install() {
  if exists "vim" && exists "nvim" ; then
    echo "Find both 'vim' and 'nvim' in your system"
    while true; do
      echo -e "Install $YSVIM_NAME for:\n\t[0]vim\n\t[1]nvim\n\t[2]both vim and nvim"
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
      install_for_nvim
  else
      echo "You must have 'vim' or 'nvim' installed to continue"
  fi
}

# Main
check "git"
update_repo
install
echo "$YSVIM_NAME installed successfully!"
