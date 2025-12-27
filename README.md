# Neovim & Dev Stack Installer

A lightweight shell script to bootstrap **NvChad**, **Node.js (via NVM)**, and **OpenTofu** on Debian-based systems. Optimized for both standard Linux environments and `proot-distro` (Termux).

## Features

* **Neovim:** Latest Stable (via AppImage).
* **NvChad:** Clean install of the NvChad starter template.
* **Node.js:** LTS version managed by NVM (No sudo required for Node).
* **OpenTofu:** Official repository installation.
* **Tools:** Includes `ripgrep`, `fd-find`, `build-essential`, and `xclip`.

## Usage

### 1. Standard Install (No Sudo / proot-distro)

Best for environments where you are already root or don't have sudo access (like Termux `proot-distro`).

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/install.sh | bash

```

### 2. Install with Sudo

Use this for standard Debian/Ubuntu/WSL installations where root privileges are required for system packages.

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/install.sh | bash -s -- --sudo

```

## Post-Installation

After the script finishes, refresh your shell environment to activate **NVM**:

```bash
source ~/.bashrc
# OR
source ~/.zshrc

```

Then, simply run `nvim` to start the NvChad plugin synchronization:

```bash
nvim

```

## Requirements

* `curl` and `git` must be installed.
* Debian-based distribution (Ubuntu, Kali, Linux Mint, etc.).
