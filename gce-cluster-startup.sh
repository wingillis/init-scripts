
mkdir dev
mkdir data

# download miniconda
curl https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o "$HOME/miniconda3_latest.sh"

cd dev

git clone https://github.com/dattalab/moseq2-extract.git
git clone https://github.com/dattalab/moseq2-pca.git
git clone https://github.com/dattalab/moseq2-model.git
git clone https://github.com/dattalab/moseq2-batch.git
git clone https://github.com/dattalab/moseq2-viz.git

cd $HOME
bash miniconda3_latest.sh -b -p $HOME/miniconda3

echo "export PATH=$HOME/miniconda3/bin:\$PATH" >> .bashrc

source $HOME/.bashrc

pip install -e dev/moseq2-extract
pip install -e dev/moseq2-pca
pip install -e dev/moseq2-model --process-dependency-links
pip install -e dev/moseq2-batch
pip install -e dev/moseq2-viz

gsutil -m cp -r gs://datta-shared-data/cables-2 $HOME/data/

git config --global user.email "win.gillis@gmail.com"
git config --global user.name "Winthrop Gillis"

