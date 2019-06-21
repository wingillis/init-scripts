########## VIM setup ##########

mkdir -p $HOME/.vim/ftplugin

git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

ln -s $HOME/dev/init-scripts/vim-ft-exts/*.vim $HOME/.vim/ftplugin/

ln -s $HOME/dev/init-scripts/.vimrc $HOME/.vimrc

echo | vim +PluginInstall +qall

