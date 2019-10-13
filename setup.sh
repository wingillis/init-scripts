set -e

###### folder setup ###### 

mkdir -p $HOME/dev

ln -s $HOME/dev/init-scripts/slorc /usr/local/bin/

ln -s "$HOME/Dropbox (HMS)" $HOME/db-hms

########## VIM setup ##########

# install vim-plug (plugin manager)
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# markdown settings
mkdir -p $HOME/.vim/ftplugin
ln -s $HOME/dev/init-scripts/vim-ft-exts/*.vim $HOME/.vim/ftplugin/

ln -s $HOME/dev/init-scripts/.vimrc $HOME/.vimrc

echo | vim +PlugInstall +qall

###### jupyter install ######

# for this section, make sure you run it like:
# . ./setup.sh

conda install -n lab -y -c conda-forge ffmpeg

conda activate lab

pip install -U pip
pip install jupyterlab ipywidgets

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export NODE_OPTIONS=--max-old-space-size=4096
jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
jupyter labextension install @jupyterlab/toc --no-build
jupyter labextension install jupyterlab_vim --no-build
jupyter labextension install @jupyterlab/celltags --no-build
jupyter labextension install @oriolmirosa/jupyterlab_materialdarker --no-build
jupyter labextension install @pyviz/jupyterlab_pyviz --no-build
jupyter labextension install jupyterlab-plotly --no-build
jupyter labextension install plotlywidget --no-build
unset NODE_OPTIONS

jupyter lab build

ln -s $HOME/dev/init-scripts/o2-jupyter.py /usr/local/bin/jupyter-connect
