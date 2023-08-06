echo "Initializing..."
cd ~
echo "At"
pwd
rm -rf .bashrc .bash_profile .gitconfig .gitignore-global .emacs .emacs.d .vimrc .vim .config/nvim .config/tmux
mkdir .config
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
echo "Setting up NeoVim"
ln -s .dotfiles/nvim .config/nvim
echo "Setting up tmux"
ln -s .dotfiles/tmux .config/tmux
echo "Refreshing bash"
source ~/.bashrc
echo "Setting up brew"
which -s brew
if ! [[ $? == 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo "Installing tools..."
brew install bash bash-completion emacs vim git neovim ripgrep
echo "Reviewing..."
bash --version
emacs --version
git --version
vim --version
nvim --version
rg --version
echo "Done"

