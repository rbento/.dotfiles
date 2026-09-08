#!/bin/bash

echo "Starting..."

# ── Dotfiles: backup ──────────────────────────────────────────────────────────
cd ~
[ -f .bashrc ] && cp .bashrc .bashrc.bck
mkdir -p .config

echo "Upgrading..."

# ── System: full upgrade ──────────────────────────────────────────────────────
sudo dnf upgrade --refresh -y

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
ln -sfn .dotfiles/vim/vimrc            .vimrc
ln -sfn .dotfiles/vim                  .vim
ln -sfn .dotfiles/vim/ideavimrc        .ideavimrc

echo "Installing..."

# ── Packages: RPM Fusion repositories ─────────────────────────────────────────
sudo dnf install -y --skip-unavailable \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# ── Packages: system & desktop ────────────────────────────────────────────────
sudo dnf install -y --skip-unavailable fuse-libs hack-fonts libX11-devel plasma-workspace-x11 xorg-x11-server-Xorg

# ── Packages: shell & CLI utilities ───────────────────────────────────────────
sudo dnf install -y --skip-unavailable bash bash-completion bat btop curl fd-find fzf jq nmap ripgrep tmux tree wget wl-clipboard xclip

# ── Packages: editors ─────────────────────────────────────────────────────────
sudo dnf install -y --skip-unavailable emacs mousepad vim-X11 vim-enhanced

# ── Packages: compilers & build tools ─────────────────────────────────────────
sudo dnf install -y --skip-unavailable bear clang clang-tools-extra cmake ctags gcc gcc-c++ make mold ninja-build

# ── Packages: assemblers ──────────────────────────────────────────────────────
sudo dnf install -y --skip-unavailable cc65 dasm nasm

# ── Packages: languages ───────────────────────────────────────────────────────
sudo dnf install -y --skip-unavailable lua perl

# ── Packages: version control ─────────────────────────────────────────────────
sudo dnf install -y --skip-unavailable git git-lfs

# ── Packages: debugging & profiling ───────────────────────────────────────────
sudo dnf install -y --skip-unavailable binutils cppcheck gdb hotspot lldb perf rr

# ── Packages: GPU & graphics tools ────────────────────────────────────────────
sudo dnf install -y --skip-unavailable corectrl mangohud radeontop renderdoc

# ── Packages: emulators ───────────────────────────────────────────────────────
sudo dnf install -y --skip-unavailable fceux stella

# ── Packages: graphics drivers & video (64-bit) ───────────────────────────────
sudo dnf install -y --skip-unavailable libva-utils mesa-dri-drivers mesa-va-drivers mesa-vulkan-drivers

# ── Packages: graphics drivers (32-bit, Steam/Proton) ─────────────────────────
sudo dnf install -y --skip-unavailable mesa-dri-drivers.i686 mesa-vulkan-drivers.i686 vulkan-loader.i686

# ── Packages: Vulkan development ──────────────────────────────────────────────
sudo dnf install -y --skip-unavailable vulkan-headers vulkan-loader vulkan-loader-devel vulkan-tools vulkan-validation-layers

# ── Packages: shader toolchain ────────────────────────────────────────────────
sudo dnf install -y --skip-unavailable glslang glslc spirv-cross spirv-tools

# ── Packages: gamedev libraries ───────────────────────────────────────────────
sudo dnf install -y --skip-unavailable glm-devel SDL3-devel

# ── Video: swap to RPM Fusion codecs ──────────────────────────────────────────
sudo dnf swap -y --allowerasing mesa-va-drivers mesa-va-drivers-freeworld
sudo dnf swap -y --allowerasing mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
sudo dnf swap -y --allowerasing ffmpeg-free ffmpeg

# ── System: GPU device access groups ──────────────────────────────────────────
sudo usermod -aG render,video $USER

# ── Config: Vim plugin manager ────────────────────────────────────────────────
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# ── Config: SDKMAN (Java) ─────────────────────────────────────────────────────
curl -s "https://get.sdkman.io" | bash

# ── Config: GDB dashboard ─────────────────────────────────────────────────────
wget -P ~ https://github.com/cyrus-and/gdb-dashboard/raw/master/.gdbinit

# ── Config: Python user tools ─────────────────────────────────────────────────
sudo dnf install -y --skip-unavailable pipx python3-pygments
pipx install pipenv

echo "Verifying..."

# ── Verify: versions ──────────────────────────────────────────────────────────
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
tree --version
wget --version

# ── Verify: GPU & Vulkan ──────────────────────────────────────────────────────
lspci -k | grep -EA3 'VGA|3D|Display'   # expect: Kernel driver in use: amdgpu
vulkaninfo | grep -i deviceName         # expect: AMD Radeon Graphics (RADV GFX1103)
vkcube                                # spinning cube = RADV OK (opens a window; run manually)

echo "Done"
