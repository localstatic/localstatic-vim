
Morgan Terry's Vim Configuration
================================

This was originally based on [spf13/spf13-vim](https://github.com/spf13/spf13-vim), but with many things stripped out & other things added. It's probably diverged a fair amount since then, but I thank spf13 for the inspiration to finally get my vim config in order.

Installation
------------

After installing your vim of choice, the following steps should get you going.

1. Clone this repo to the desired location
2. Symlink vimrc & vim into your home directory (i.e. ~/.vimrc and ~/.vim)
3. `git submodule init`
4. `git submodule update`
5. Install plugins
  * `vim +PluginInstall +qall` or run Vim and run `:PlugnInstall`
6. (optional) Install [Powerline version of the "Anonymous Pro"](https://github.com/powerline/fonts/tree/master/AnonymousPro) font
