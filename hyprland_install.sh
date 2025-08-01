# anshul333y's hyprland installer script

printf '\033c'

# creating user-dirs
mkdir -p code dl pub docs music pics vids ~/.local/share

# installing pacman packages
sudo pacman -S --noconfirm networkmanager dhcpcd bluez bluez-utils pipewire pipewire-pulse \
  dash zsh git openssh stow cronie noto-fonts noto-fonts-cjk noto-fonts-emoji \
  hyprland hyprpaper hypridle hyprlock rofi-wayland waybar dunst polkit-gnome gnome-keyring \
  qt5-wayland qt6-wayland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-user-dirs \
  uwsm brightnessctl acpi pacman-contrib python-pywal xorg-xrdb unzip 7zip ntfs-3g udisks2 \
  firefox telegram-desktop discord flatpak sxiv yazi poppler mpv mpd ncmpcpp mpc \
  kitty wl-clipboard nvim lazygit fzf ripgrep fd tmux nodejs npm docker

# installing flatpak packages
flatpak install --noninteractive flathub com.github.wwmm.easyeffects

# enabling systemd services
sudo systemctl enable NetworkManager.service
sudo systemctl enable bluetooth.service
sudo systemctl enable cronie.service

# changing shell to zsh
sudo chsh -s /usr/bin/zsh

# installing LazyVim
git clone https://github.com/LazyVim/starter ~/.config/nvim

# installing dotfiles
git clone https://github.com/anshul333y/.dotfiles.git
cd ~/.dotfiles && stow . && cd

# installing oh-my-zsh with plugins
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use

# installing font
curl -Lo ~/dl/font.zip "https://github.com/subframe7536/maple-font/releases/download/v7.4/MapleMono-NF-CN-unhinted.zip"
unzip ~/dl/font.zip -d ~/dl/fonts && mv ~/dl/fonts ~/.local/share && fc-cache -fv && rm ~/dl/font.zip

# installing aur helper paru
git clone https://aur.archlinux.org/paru-bin.git ~/dl/paru
cd ~/dl/paru && makepkg -si --noconfirm && cd && rm -rf ~/dl/paru

# installing aur packages
paru -S --noconfirm hyprshot-git wlogout-git python-pywalfox google-chrome brave-bin \
  visual-studio-code-bin

# post install steps
rm .bash* .zshrc
