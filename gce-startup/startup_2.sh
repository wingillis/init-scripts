PATH=$HOME/miniconda3/bin:$PATH

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

nvm install node
npm update -g npm 

conda install -y -c conda-forge ffmpeg

pip install -U pip
pip install jupyterlab matplotlib cython

# install jupyterlab extensions
jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
jupyter labextension install @jupyterlab/toc --no-build
jupyter labextension install jupyterlab_vim --no-build
jupyter labextension install @jupyterlab/celltags --no-build
jupyter labextension install @oriolmirosa/jupyterlab_materialdarker --no-build
jupyter labextension install @pyviz/jupyterlab_pyviz --no-build
jupyter lab build

for suffix in "${seqnames[@]}"; do
	pip install -e $HOME/dev/moseq2/moseq2-$suffix
done

jupyterconfig="$HOME/.jupyter/lab/user-settings/@jupyterlab/"

mkdir -p $jupyterconfig/notebook-extension
mkdir -p $jupyterconfig/shortcuts-extension

rm $jupyterconfig/notebook-extension/tracker.jupyerlab-settings
rm $jupyterconfig/shortcuts-extension/plugin.jupyterlab-settings

ln -s $HOME/init-scripts/jupyterlab-notebook-settings.json $jupyterconfig/notebook-extension/tracker.jupyterlab-settings
ln -s $HOME/init-scripts/jupyterlab-keyboard-shortcuts.json $jupyterconfig/shortcuts-extension/plugin.jupyterlab-settings

mkdir -p $HOME/.config/matplotlib/stylelib

rm $HOME/.config/matplotlib/stylelib/win-dark.mplstyle

ln -s $HOME/init-scripts/dark-settings.yaml $HOME/.config/matplotlib/stylelib/win-dark.mplstyle