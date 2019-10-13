cd $HOME

pform=$(uname -v)
if echo $pform | grep -q 'Debian'; then
	installer=apt
else
	installer=yum
fi

mkdir -p $HOME/dev/moseq2
mkdir -p $HOME/data

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
git checkout v0.2.0
cd ../moseq2-pca
git checkout v0.2.0
cd ../moseq2-batch
git checkout v0.2.0
cd ../moseq2-viz
git checkout v0.2.0
cd ../moseq2-extract
git checkout v0.2.0

cd $HOME
rm -rf miniconda3
bash miniconda3_latest.sh -b -p $HOME/miniconda3

if tail -n 1 $HOME/.bashrc | grep -q 'miniconda'; then
	echo "miniconda export already added"
else
	echo "export PATH=$HOME/miniconda3/bin:\$PATH" >> .bashrc
fi

if [ -f $HOME/.bash_profile ]; then
	echo "found a bash profile"
else
	echo "did not find bash_profile, making..."
	touch $HOME/.bash_profile
	echo ". $HOME/.bashrc" >> .bash_profile
fi

. $HOME/.bashrc

# install ffmpeg
conda install -y -c conda-forge ffmpeg

pip install -U pip
pip install jupyterlab matplotlib cython

for suffix in "${seqnames[@]}"; do
	pip install -e dev/moseq2/moseq2-$suffix
done

exec "sudo $installer install -y zsh"
#sudo yum install -y zsh nodejs

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

rm $HOME/.zshrc
ln -s $HOME/init-scripts/gce-zshrc.zsh $HOME/.zshrc
rm $HOME/.tmux.conf
ln -s $HOME/init-scripts/.tmux.conf $HOME/.tmux.conf

echo "exec zsh" >> $HOME/.bash_profile

rm $HOME/miniconda3_latest.sh

gcloud auth login

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -s $HOME/init-scripts/.vimrc $HOME/.vimrc

echo | vim +PlugInstall +qall

jupyterconfig="$HOME/.jupyter/lab/user-settings/@jupyterlab/"
mkdir -p $jupyterconfig/notebook-extension
ln -s $HOME/init-scripts/jupyterlab-notebook-settings.json $jupyterconfig/notebook-extension/tracker.jupyterlab-settings
mkdir -p $jupyterconfig/shortcuts-extension
ln -s $HOME/init-scripts/jupyterlab-keyboard-shortcuts.json $jupyterconfig/shortcuts-extension/plugin.jupyterlab-settings

mkdir -p $HOME/.config/matplotlib/stylelib
ln -s $HOME/init-scripts/dark-settings.yaml $HOME/.config/matplotlib/stylelib/win-dark.mplstyle

# . $HOME/.bash_profile

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

nvm install node
npm update -g npm 

# install jupyterlab extensions
jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
jupyter labextension install @jupyterlab/toc --no-build
jupyter labextension install jupyterlab_vim --no-build
jupyter labextension install @jupyterlab/celltags --no-build
jupyter labextension install @oriolmirosa/jupyterlab_materialdarker --no-build
jupyter labextension install @pyviz/jupyterlab_pyviz --no-build
jupyter lab build


