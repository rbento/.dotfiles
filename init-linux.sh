#!/bin/bash
echo "Initializing..."
cd ~
echo "At"
pwd
cp .bashrc .bashrc.bck
mkdir .config
rm -rf .bashrc .bash_profile .gitconfig .gitignore-global .emacs .emacs.d .vimrc .vim .config/tmux
echo "Setting up bash"
ln -s .dotfiles/bash/bashrc .bashrc
ln -s .bashrc .bash_profile
echo "Setting up emacs"
ln -s .dotfiles/emacs/emacs .emacs
echo "Setting up git"
ln -s .dotfiles/git/gitconfig .gitconfig
ln -s .dotfiles/git/gitignore-global .gitignore-global
echo "Setting up vim"
ln -s .dotfiles/vim/vimrc .vimrc
ln -s .dotfiles/vim .vim
ln -s .dotfiles/vim/ideavimrc .ideavimrc
echo "Setting up tmux"
ln -s .dotfiles/tmux .config/tmux
echo "Refreshing bash"
source ~/.bashrc
echo "Installing tools..."
sudo yum install bash bash-completion bat curl ctags emacs fd-find fzf gcc gdb git git-lfs jq kubernetes perl ripgrep ruby tmux tree wget
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -s "https://get.sdkman.io" | bash
wget -P ~ https://github.com/cyrus-and/gdb-dashboard/raw/master/.gdbinit
pip install pygments
echo "Reviewing..."
bash --version
curl --version
ctags --version
emacs --version
fd --version
fzf --version
git --version
jq --version
perl --version
rg --version
tmux -V
tree --version
wget --version
echo "Done"
