
mkdir -p $HOME/dev/moseq2
mkdir -p $HOME/data

# download miniconda
curl https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o "$HOME/miniconda3_latest.sh"

git config --global user.name wingillis
git config --global user.email "win.gillis@gmail.com"
git config --global credential.helper cache

cd $HOME/dev/moseq2

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

rm $HOME/miniconda3_latest.sh

if [ -f $HOME/.zshrc ]; then
    rm $HOME/.zshrc
fi
ln -s $HOME/init-scripts/gce-zshrc.zsh $HOME/.zshrc
if [ -f $HOME/.tmux.conf ]; then
    rm $HOME/.tmux.conf
fi
ln -s $HOME/init-scripts/.tmux.conf $HOME/.tmux.conf
if [ -f $HOME/.vimrc ]; then
    rm $HOME/.vimrc
fi
ln -s $HOME/init-scripts/.vimrc $HOME/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
