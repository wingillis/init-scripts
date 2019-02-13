cd $HOME

mkdir -p dev/moseq2
mkdir data

# download miniconda
curl https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o "$HOME/miniconda3_latest.sh"

git config --global user.name wingillis
git config --global user.email "win.gillis@gmail.com"
git config --global credential.helper cache

cd dev/moseq2

declare -a seqnames=("extract" "pca" "model" "batch" "viz")

for suffix in "${seqnames[@]}"; do
	[ -d moseq2-$suffix ] && rm -rf moseq2-$suffix
	git clone https://wingillis@github.com/dattalab/moseq2-${suffix}.git
done

cd moseq2-model
git checkout v0.1.2-e-step
cd ../moseq2-pca
git checkout v0.1.3
cd ../moseq2-batch
git checkout v0.1.3
cd ../moseq2-viz
git checkout v0.1.3
cd ../moseq2-extract
git checkout v0.1.3

cd $HOME
rm -rf miniconda3
bash miniconda3_latest.sh -b -p $HOME/miniconda3

echo "export PATH=$HOME/miniconda3/bin:\$PATH" >> .bashrc

. $HOME/.bash_profile

# install ffmpeg
conda install -y -c conda-forge ffmpeg

pip install -U pip
pip install jupyterlab matplotlib cython

for suffix in "${seqnames[@]}"; do
	pip install -e dev/moseq2/moseq2-$suffix
done

sudo yum install -y zsh nodejs
sudo npm install -g nvm
nvm install v11.9

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

rm $HOME/.zshrc
ln -s $HOME/init-scripts/gce-zshrc.zsh $HOME/.zshrc
ln -s $HOME/init-scripts/.tmux.conf $HOME/.tmux.conf

echo "exec zsh" >> $HOME/.bash_profile

rm $HOME/miniconda3_latest.sh

gcloud auth login

git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
ln -s $HOME/init-scripts/.vimrc $HOME/.vimrc

# install jupyterlab extensions
jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter labextension install @jupyterlab/toc
jupyter labextension install jupyterlab_vim
jupyter labextension install @jupyterlab/celltags
jupyter labextension install @oriolmirosa/jupyterlab_materialdarker

jupyterconfig="$HOME/.jupyter/lab/user-settings/@jupyterlab/"
mkdir -p $jupyterconfig/notebook-extension
ln -s $HOME/init-scripts/jupyterlab-notebook-settings.json $jupyterconfig/notebook-extension/tracker.jupyterlab-settings
mkdir -p $jupyterconfig/shortcuts-extension
ln -s $HOME/init-scripts/jupyterlab-keyboard-shortcuts.json $jupyterconfig/shortcuts-extension/plugin.jupyterlab-settings

mkdir -p $HOME/.config/matplotlib/stylelib
ln -s $HOME/init-scripts/dark-settings.yaml $HOME/.config/matplotlib/stylelib/win-dark.mplstyle

. $HOME/.bash_profile
