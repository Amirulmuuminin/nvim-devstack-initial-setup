#!/bin/bash

# Default: Tanpa sudo
SUDO=""

# Cek apakah ada parameter --sudo
for arg in "$@"; do
  if [ "$arg" == "--sudo" ]; then
    SUDO="sudo"
    break
  fi
done

set -e

echo "🚀 Memulai Instalasi My NvChad Stack + NVM + Neovim LATEST + LazyGit + OpenTofu..."

# 1. Update sistem
$SUDO apt update

# 2. Install Dependencies dasar via APT (Tanpa neovim karena kita install manual)
$SUDO apt install -y lazygit git unzip build-essential xclip ripgrep fd-find curl tar

# 3. Install Neovim TERBARU (Manual Binary)
echo "📦 Downloading Neovim Latest Binary..."
cd ~
# Mendeteksi arsitektur (arm64 untuk kebanyakan Android, x86_64 untuk PC)
ARCH=$(uname -m)
if [ "$ARCH" == "aarch64" ]; then
    NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz"
    NVIM_DIR_NAME="nvim-linux-arm64"
else
    NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"
    NVIM_DIR_NAME="nvim-linux64"
fi

curl -LO $NVIM_URL
tar xzf "${NVIM_DIR_NAME}.tar.gz"

# Pindahkan ke /usr/local agar bisa diakses secara global
echo "Installing Neovim to /usr/local..."
$SUDO cp -r $NVIM_DIR_NAME/bin/* /usr/local/bin/
$SUDO cp -r $NVIM_DIR_NAME/lib/* /usr/local/lib/
$SUDO cp -r $NVIM_DIR_NAME/share/* /usr/local/share/

# Bersihkan sisa download
rm -rf $NVIM_DIR_NAME "${NVIM_DIR_NAME}.tar.gz"

# 4. Install NVM & Node.js LTS
echo "Installing NVM..."
export NVM_DIR="$HOME/.nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Load NVM agar bisa langsung pakai 'nvm' dalam script ini
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Installing Node.js LTS via NVM..."
nvm install --lts
nvm use --lts

# 5. Install OpenTofu (Official Script)
echo "Installing OpenTofu..."
curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh
chmod +x install-opentofu.sh
if [ "$SUDO" == "sudo" ]; then
    sudo ./install-opentofu.sh --install-method deb
else
    ./install-opentofu.sh --install-method deb
fi
rm -f install-opentofu.sh

# 6. Clone Custom NvChad Config
echo "Cloning your custom NvChad configuration..."
if [ -d "$HOME/.config/nvim" ]; then
    echo "Backing up existing config..."
    mv ~/.config/nvim ~/.config/nvim_backup_$(date +%Y%m%d_%H%M%S)
fi

git clone https://github.com/Amirulmuuminin/my-nvchad.git ~/.config/nvim --depth 1

echo ""
echo "✅ Instalasi Selesai!"
echo "----------------------------------------------------"
echo "1. Jalankan: source ~/.bashrc"
echo "2. Jalankan: nvim"
echo "3. Di dalam Neovim, tunggu Mason & Lazy selesai install otomatis."
echo "4. Cek OpenTofu dengan: tofu --version"
