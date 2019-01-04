cd $HOME

mkdir dev
mkdir -p data/1pimaging

# download miniconda
curl https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o "$HOME/miniconda3_latest.sh"

cd dev

git config --global user.name wingillis
git config --global user.email "win.gillis@gmail.com"
git config --global credential.helper credential-cache

rm -rf moseq2-extract
rm -rf moseq2-pca
rm -rf moseq2-model
rm -rf moseq2-batch
rm -rf moseq2-viz
git clone https://wingillis@github.com/dattalab/moseq2-extract.git
git clone https://wingillis@github.com/dattalab/moseq2-pca.git
git clone https://wingillis@github.com/dattalab/moseq2-model.git
git clone https://wingillis@github.com/dattalab/moseq2-batch.git
git clone https://wingillis@github.com/dattalab/moseq2-viz.git

cd moseq2-model
git checkout v0.1.2
cd ../moseq2-pca
git checkout v0.1.2
cd ../moseq2-batch
git checkout v0.1.2
cd ../moseq2-viz
git checkout v0.1.2

cd $HOME
bash miniconda3_latest.sh -b -p $HOME/miniconda3

echo "export PATH=$HOME/miniconda3/bin:\$PATH" >> .bashrc

. $HOME/.bash_profile

# install ffmpeg
conda install -c conda-forge ffmpeg

pip install -e dev/moseq2-extract
pip install -e dev/moseq2-pca
pip install -e dev/moseq2-model --process-dependency-links
pip install -e dev/moseq2-batch
pip install -e dev/moseq2-viz

pip install jupyter
pip install matplotlib
pip install cython

git config --global user.email "win.gillis@gmail.com"
git config --global user.name "Winthrop Gillis"

sudo yum install -y zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

rm $HOME/.zshrc
ln -s $HOME/init-scripts/gce-zshrc.zsh $HOME/.zshrc
ln -s $HOME/init-scripts/.tmux.conf $HOME/.tmux.conf

echo "exec zsh" >> $HOME/.bash_profile

rm $HOME/miniconda3_latest.sh

gcloud auth login

sbatch -t 12:00:00 -n 1 -c 8 --mem=30G --wrap "gsutil -m cp -r gs://datta-shared-data/1pimaging-vae-modeling $HOME/data/1pimaging"

. $HOME/.bash_profile
