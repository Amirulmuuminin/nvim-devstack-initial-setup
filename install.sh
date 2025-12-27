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

echo "🚀 Memulai Instalasi NvChad + NVM (Node.js) + OpenTofu..."

# 1. Update sistem
$SUDO apt update

# 2. Dependencies dasar & pendukung NvChad
$SUDO apt install -y git curl wget unzip build-essential xclip libfuse2 ripgrep fd-find

# 3. Install NVM & Node.js LTS
echo "Installing NVM..."
export NVM_DIR="$HOME/.nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Load NVM ke sesi sekarang agar bisa langsung pakai 'nvm'
[ -s "$NVM_DIR/nvm.sh" ] && \. "$SUDO $NVM_DIR/nvm.sh" 
export PATH="$NVM_DIR/versions/node/$(nvm version)/bin:$PATH"

echo "Installing Node.js LTS via NVM..."
nvm install --lts
nvm use --lts

# 4. OpenTofu (Install via manual binary jika tanpa sudo lebih disarankan, tapi ini versi apt)
echo "Installing OpenTofu..."
$SUDO install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://get.opentofu.org/opentofu.gpg | $SUDO tee /etc/apt/keyrings/opentofu.gpg >/dev/null
echo "deb [signed-by=/etc/apt/keyrings/opentofu.gpg] https://packages.opentofu.org/opentofu/main/deb/ any any" | $SUDO tee /etc/apt/sources.list.d/opentofu.list >/dev/null
$SUDO apt update && $SUDO apt install -y tofu

# 5. Neovim Terbaru (AppImage)
# Di proot-distro/termux, AppImage mungkin tidak jalan, disarankan ganti ke pkg install nvim jika di termux
echo "Installing Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
$SUDO mv nvim.appimage /usr/local/bin/nvim || mv nvim.appimage $HOME/.local/bin/nvim 2>/dev/null || true

# 6. NvChad
if [ -d "$HOME/.config/nvim" ]; then
    mv ~/.config/nvim ~/.config/nvim_backup_$(date +%Y%m%d_%H%M%S)
fi
git clone https://github.com/NvChad/starter ~/.config/nvim --depth 1

echo ""
echo "✅ Instalasi Selesai!"
echo "PENTING: Jalankan 'source ~/.bashrc' atau restart terminal agar NVM aktif."
echo "Lalu jalankan 'nvim' untuk setup plugin."
