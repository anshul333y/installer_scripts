# anshul333y's arch installer script

#part1
printf '\033c'
sed -i "s/^ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
pacman --noconfirm -Sy archlinux-keyring
loadkeys us
timedatectl set-ntp true
partition=/dev/nvme0n1p6
mkfs.ext4 -F $partition
efipartition=/dev/nvme0n1p5
mkfs.fat -F 32 $efipartition
mount $partition /mnt
mkdir -p /mnt/boot/efi
mount $efipartition /mnt/boot/efi
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >>/mnt/etc/fstab
sed '1,/^#part2$/d' $(basename $0) >/mnt/arch_install2.sh
chmod +x /mnt/arch_install2.sh
arch-chroot /mnt ./arch_install2.sh
exit

#part2
printf '\033c'
pacman -S --noconfirm sed
sed -i "s/^ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >/etc/locale.conf
echo "KEYMAP=us" >/etc/vconsole.conf
hostname=archlinux
echo $hostname >/etc/hostname
echo "127.0.0.1       localhost" >>/etc/hosts
echo "::1             localhost" >>/etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >>/etc/hosts
mkinitcpio -P
passwd
pacman --noconfirm -S grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# installing pacman packages
pacman -S --noconfirm networkmanager dhcpcd bluez bluez-utils pipewire pipewire-pulse \
  dash zsh git openssh stow cronie noto-fonts noto-fonts-cjk noto-fonts-emoji \
  hyprland hyprpaper hypridle hyprlock rofi-wayland waybar dunst polkit-gnome gnome-keyring \
  qt5-wayland qt6-wayland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-user-dirs \
  uwsm brightnessctl acpi pacman-contrib python-pywal xorg-xrdb unzip 7zip ntfs-3g udisks2 \
  firefox telegram-desktop discord flatpak sxiv yazi poppler mpv mpd ncmpcpp mpc \
  kitty wl-clipboard nvim lazygit fzf ripgrep fd tmux nodejs npm docker

# installing flatpak packages
flatpak install --noninteractive flathub com.github.wwmm.easyeffects

# enabling systemd services
systemctl enable NetworkManager.service
systemctl enable bluetooth.service
systemctl enable cronie.service

rm /bin/sh
ln -s dash /bin/sh
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers
username=anshul333y
useradd -m -G wheel -s /bin/zsh $username
passwd $username
echo "Pre-Installation Finish Reboot now"
ai3_path=/home/$username/arch_install3.sh
sed '1,/^#part3$/d' arch_install2.sh >$ai3_path
chown $username:$username $ai3_path
chmod +x $ai3_path
su -c $ai3_path -s /bin/sh $username
exit

#part3
cd $HOME
# anshul333y's hyprland installer script

printf '\033c'

# creating user-dirs
mkdir -p code dl pub docs music pics vids ~/.local/share

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
exit
