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

echo "🚀 Memulai Instalasi My NvChad Stack + NVM + Neovim + LazyGit..."

# 1. Update sistem
$SUDO apt update

# 2. Install Neovim, LazyGit, & Dependencies dasar via APT
# Menghapus wget & curl dari daftar install, menambahkan lazygit
$SUDO apt install -y neovim lazygit git unzip build-essential xclip ripgrep fd-find

# 3. Install NVM & Node.js LTS
echo "Installing NVM..."
export NVM_DIR="$HOME/.nvm"
# Curl tetap digunakan di sini karena ini adalah perintah pengunduhan NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Load NVM agar bisa langsung pakai 'nvm' dalam script ini
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Installing Node.js LTS via NVM..."
nvm install --lts
nvm use --lts

# 4. Clone Custom NvChad Config
echo "Cloning your custom NvChad configuration..."
if [ -d "$HOME/.config/nvim" ]; then
    echo "Backing up existing config..."
    mv ~/.config/nvim ~/.config/nvim_backup_$(date +%Y%m%d_%H%M%S)
fi

# Menggunakan repo pribadimu
git clone https://github.com/Amirulmuuminin/my-nvchad.git ~/.config/nvim --depth 1

echo ""
echo "✅ Instalasi Selesai!"
echo "Silakan jalankan: source ~/.bashrc"
echo "Lalu jalankan 'nvim' untuk sinkronisasi plugin, dan 'lazygit' untuk cek git UI."
