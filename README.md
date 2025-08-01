# 🛸 Installer Scripts

A collection of simple shell scripts to automate the installation and configuration of Arch Linux, Hyprland (Wayland compositor), and Ubuntu-based systems.

---

## 📁 Scripts Overview

### `arch_install.sh`
A streamlined script to install Arch Linux with essential tools and configurations.

- Partitioning and mounting (manual/optional)
- Base system installation via `pacstrap`
- User and locale setup
- Essential packages (networking, sudo, etc.)
- GRUB installation and configuration

### `hyprland_install.sh`
Installs the Hyprland desktop environment on top of Arch Linux or an Arch-based distro.

- Hyprland + wayland utilities
- Terminal, file manager, browser, and extras
- `kitty`, `waybar`, `rofi`, and more

### `ubuntu_install.sh`
Quick setup for Ubuntu-based systems with personal or developer-focused packages.

- Updates and essential tools
- `zsh`, `git`, `curl`, `tmux`, etc.
- Developer packages and optional themes

---

## 🚀 How to Use

### 1. Clone the repository

```bash
git clone https://github.com/anshul333y/arch_installer_scripts.git
cd arch_installer_scripts && ./hyprland_install.sh
