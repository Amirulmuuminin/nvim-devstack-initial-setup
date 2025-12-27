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

echo "🚀 Memulai Instalasi My NvChad Stack + NVM + OpenTofu..."

# 1. Update sistem
$SUDO apt update

# 2. Dependencies dasar & pendukung NvChad
$SUDO apt install -y git curl wget unzip build-essential xclip libfuse2 ripgrep fd-find

# 3. Install NVM & Node.js LTS
echo "Installing NVM..."
export NVM_DIR="$HOME/.nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Load NVM agar bisa langsung pakai 'nvm' dalam script
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "Installing Node.js LTS via NVM..."
nvm install --lts
nvm use --lts

# 4. OpenTofu
echo "Installing OpenTofu..."
$SUDO install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://get.opentofu.org/opentofu.gpg | $SUDO tee /etc/apt/keyrings/opentofu.gpg >/dev/null
echo "deb [signed-by=/etc/apt/keyrings/opentofu.gpg] https://packages.opentofu.org/opentofu/main/deb/ any any" | $SUDO tee /etc/apt/sources.list.d/opentofu.list >/dev/null
$SUDO apt update && $SUDO apt install -y tofu

# 5. Neovim Terbaru (AppImage)
echo "Installing Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
# Mencoba memindah ke /usr/local/bin, jika gagal (tanpa sudo) pindah ke ~/.local/bin
$SUDO mv nvim.appimage /usr/local/bin/nvim || (mkdir -p $HOME/.local/bin && mv nvim.appimage $HOME/.local/bin/nvim) || true

# 6. Clone Custom NvChad Config
echo "Cloning your custom NvChad configuration..."
if [ -d "$HOME/.config/nvim" ]; then
    echo "Backing up existing config..."
    mv ~/.config/nvim ~/.config/nvim_backup_$(date +%Y%m%d_%H%M%S)
fi

# MENGGUNAKAN REPO PRIBADIMU
git clone https://github.com/Amirulmuuminin/my-nvchad.git ~/.config/nvim --depth 1

echo ""
echo "✅ Instalasi Selesai!"
echo "Silakan jalankan: source ~/.bashrc"
echo "Lalu jalankan 'nvim' untuk sinkronisasi plugin custom kamu."
