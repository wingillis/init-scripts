########## VIM setup ##########

# install vim-plug (plugin manager)
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# markdown settings
mkdir -p $HOME/.vim/ftplugin
ln -s $HOME/dev/init-scripts/vim-ft-exts/*.vim $HOME/.vim/ftplugin/

ln -s $HOME/dev/init-scripts/.vimrc $HOME/.vimrc

echo | vim +PlugInstall +qall

