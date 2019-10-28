#!/bin/sh

cd "$( dirname "${BASH_SOURCE[0]}" )"
dir=`pwd`

# Symlink vim directory into your home directory (i.e. ~/.vim)
cd

if [ ! -L .vimrc -a -e .vimrc ]; then
  mv .vimrc .vimrc.bak
fi

if [ ! -L .gvimrc -a -e .gvimrc ]; then
  mv .gvimrc .gvimrc.bak
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
