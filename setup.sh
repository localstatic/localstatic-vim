#!/bin/sh

cd "$( dirname "${BASH_SOURCE[0]}" )"
dir=`pwd`

# Set up submodules
git submodule init
git submodule update

# Symlink vimrc & vim into your home directory (i.e. ~/.vimrc and ~/.vim)
cd

if [ ! -L .vimrc ]; then
  if [ -e .vimrc ]; then
    mv .vimrc .vimrc.bak
  fi
  ln -s $dir/vimrc .vimrc
fi

if [ ! -L .vim ]; then
  if [ -e .vim ]; then
    mv .vim .vim.bak
  fi
  ln -s $dir/vim .vim
fi


# Install plugins
echo
echo "run `:call dein#install()` from Vim to install plugins."

#
echo
echo "(optional) Install the Hack font for increased awesomeness."
echo "  http://sourcefoundry.org/hack/"
