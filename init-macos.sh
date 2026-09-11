#!/bin/bash

echo "Starting..."

# ── Xcode Command Line Tools: compiler base (clang, clang++, make, lldb, git) ──
xcode-select --install 2>/dev/null

# ── Dotfiles: backup ──────────────────────────────────────────────────────────
cd ~
[ -f .bashrc ] && cp .bashrc .bashrc.bck
mkdir -p .config

echo "Cleaning Up..."

# ── Dotfiles: reset & symlink ─────────────────────────────────────────────────
rm -rf .bashrc .bash_profile .bash_aliases .gitconfig .gitignore-global .emacs .emacs.d .vimrc .vim .ideavimrc

echo "Creating Symlinks..."

ln -sfn .dotfiles/bash/bashrc          .bashrc
ln -sfn .dotfiles/bash/aliases         .bash_aliases
ln -sfn .bashrc                        .bash_profile
ln -sfn .dotfiles/emacs/emacs          .emacs
ln -sfn .dotfiles/git/gitconfig        .gitconfig
ln -sfn .dotfiles/git/gitignore-global .gitignore-global
ln -sfn .dotfiles/config/ripgrep       .config/ripgrep
ln -sfn .dotfiles/vim/vimrc            .vimrc
ln -sfn .dotfiles/vim                  .vim
ln -sfn .dotfiles/vim/ideavimrc        .ideavimrc

echo "Refreshing bash"
source ~/.bashrc

echo "Installing..."

# ── Homebrew: install if missing ──────────────────────────────────────────────
which -s brew
if ! [[ $? == 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# ── Homebrew: ensure on PATH for this session (Apple Silicon vs Intel) ─────────
if   [ -x /opt/homebrew/bin/brew ]; then eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew   ]; then eval "$(/usr/local/bin/brew shellenv)"
fi

# ── Packages: shell & CLI utilities ───────────────────────────────────────────
brew install bash bash-completion bat btop curl fd fzf jq nmap ripgrep the_silver_searcher tree wget

# ── Packages: editors ─────────────────────────────────────────────────────────
brew install emacs macvim

# ── Packages: compilers & build tools ─────────────────────────────────────────
# llvm is keg-only; it supplies clangd/clang-tidy/clang-format for the vim LSP.
brew install bear cmake gcc llvm make ninja universal-ctags

# ── Packages: assemblers ──────────────────────────────────────────────────────
brew install cc65 dasm nasm

# ── Packages: languages & runtimes ────────────────────────────────────────────
brew install lua perl ruby

# ── Packages: version control ─────────────────────────────────────────────────
brew install git git-gui git-lfs gitg

# ── Packages: debugging & analysis ────────────────────────────────────────────
# lldb ships with Xcode CLT. gdb/perf/rr/hotspot are Linux-only and skipped.
brew install binutils cppcheck

# ── Packages: misc work tools ─────────────────────────────────────────────────
brew install grpcurl mitmproxy wireshark dbeaver

# ── Config: Vim plugin manager ────────────────────────────────────────────────
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# ── Config: SDKMAN (Java) ─────────────────────────────────────────────────────
curl -s "https://get.sdkman.io" | bash

# ── Config: Python user tools ─────────────────────────────────────────────────
brew install pipx pygments
pipx install pipenv

echo "Verifying..."

# ── Verify: versions ──────────────────────────────────────────────────────────
bash --version
curl --version
ctags --version
emacs --version
fd --version
fzf --version
gcc --version
git --version
grpcurl --version
jq --version
mvim --version
nasm --version
perl --version
pyenv --version
rg --version
tmux -V
tree --version
wget --version

# clangd is keg-only under llvm - add "$(brew --prefix llvm)/bin" to PATH in bashrc
"$(brew --prefix llvm)/bin/clangd" --version 2>/dev/null

echo "Done"
