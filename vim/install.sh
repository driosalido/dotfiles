#!/usr/bin/env bash

if [ -d ~/.vim_runtime/ ] ; then
    echo "vimrc already installed"
else
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
    echo "vimrc installed"
fi
