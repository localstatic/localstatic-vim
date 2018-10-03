#!/bin/sh

cd "$( dirname "${BASH_SOURCE[0]}" )"
dir=`pwd`

# Symlink vimrc, gvimrc and vim into your home directory (i.e. ~/.vimrc ~/.gvimrc and ~/.vim)
cd

if [ ! -L .vimrc ]; then
  if [ -e .vimrc ]; then
    mv .vimrc .vimrc.bak
  fi
  ln -s $dir/vimrc .vimrc
fi

if [ ! -L .gvimrc ]; then
  if [ -e .gvimrc ]; then
    mv .gvimrc .gvimrc.bak
  fi
  ln -s $dir/gvimrc .gvimrc
fi

if [ ! -L .vim ]; then
  if [ -e .vim ]; then
    mv .vim .vim.bak
  fi
  ln -s $dir/vim .vim
fi

# Download vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install plugins
vim +PlugInstall +qall

#
echo
echo "(optional) Install the Hack font for increased awesomeness."
echo "  http://sourcefoundry.org/hack/"
