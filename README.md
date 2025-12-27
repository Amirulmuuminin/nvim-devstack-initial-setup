# Neovim & Dev Stack Installer

A lightweight bootstrap script to set up a professional development environment featuring **NvChad**, **~~Node.js (NVM)~~ Bun**, and **OpenTofu**.

## Features

* **Neovim:** Latest Stable release.
* **NvChad:** Automated installation of the NvChad starter configuration.
* ~~**Node.js LTS:** Managed via **NVM** (installed in `$HOME`, no sudo needed for npm globals)~~.
* **Bun**: We have shifted from Node.js LTS (v24+) to **Bun**. Node.js v24+ frequently encounters a `double free or corruption (out)` error. **Bun** is significantly more stable, memory-efficient, and faster for proot-distro termux.
* **OpenTofu:** Official repository setup for Infrastructure as Code.
* **Essentials:** `ripgrep`, `fd-find`, `build-essential`, and `xclip` for clipboard support.

## Installation

### 1. Standard Environment (Using Sudo)

For standard Debian, Ubuntu, or WSL setups where root privileges are required:

```bash
curl -fsSL https://raw.githubusercontent.com/Amirulmuuminin/nvim-devstack-initial-setup/main/install.sh | bash -s -- --sudo

```

### 2. Proot-Distro / No-Sudo

For environments like Termux `proot-distro` where `sudo` is not available or required:

```bash
curl -fsSL https://raw.githubusercontent.com/Amirulmuuminin/nvim-devstack-initial-setup/main/install.sh | bash

```

## Post-Installation

1. **Refresh your shell** to enable `nvm` and `node`:
```bash
source ~/.bashrc

```


2. **Launch Neovim** to trigger the automatic plugin installation:
```bash
nvim

```



## Requirements

* `curl` and `git` installed on the host system.
* A Debian-based Linux distribution.
