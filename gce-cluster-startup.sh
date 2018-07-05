
mkdir dev
mkdir data

# download miniconda
curl https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o "$HOME/miniconda3_latest.sh"

cd dev

git clone https://wingillis@github.com/dattalab/moseq2-extract.git
git clone https://wingillis@github.com/dattalab/moseq2-pca.git
git clone https://wingillis@github.com/dattalab/moseq2-model.git
git clone https://wingillis@github.com/dattalab/moseq2-batch.git
git clone https://wingillis@github.com/dattalab/moseq2-viz.git

cd $HOME
bash miniconda3_latest.sh -b -p $HOME/miniconda3

echo "export PATH=$HOME/miniconda3/bin:\$PATH" >> .bashrc

. $HOME/.bash_profile

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

echo "exec zsh" >> $HOME/.bash_profile

gcloud auth login

sbatch -t 12:00:00 -n 1 -c 8 --mem=30G --wrap "gsutil -m cp -r gs://datta-shared-data/cables-2 $HOME/data/"

. $HOME/.bash_profile
