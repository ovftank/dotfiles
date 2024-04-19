#!/bin/bash

# Function to configure pacman
configure_pacman() {
    echo "Color" | sudo tee -a /etc/pacman.conf
    echo "IgnorePkg   = python" | sudo tee -a /etc/pacman.conf
}

# Function to install packages using pacman
install_pacman_packages() {
    sudo pacman -Syyu
    sudo pacman -S pcmanfm i3-wm lxappearance-gtk3 xorg-server xorg-xinit acpi feh php alacritty zsh git ttf-jetbrains-mono-nerd zsh-syntax-highlighting maim xclip rofi pulseaudio polybar --needed --noconfirm
    sudo pacman -S --needed git go --noconfirm
}

# Function to install yay and AUR packages
install_yay_and_aur_packages() {
    if ! command -v yay &>/dev/null; then
        git clone https://aur.archlinux.org/yay.git
        cd yay || exit
        makepkg -si
    else
        yay -S downgrade visual-studio-code-bin google-chrome ibus-bamboo normcap --noconfirm
        downgrade -y python
        python -m ensurepip --upgrade
        sudo pacman -S telegram-desktop -y
        sudo ln -s /usr/lib/libpython3.10.so /usr/lib/libpython3.11.so.1.0
        sudo ln -s /usr/lib/libpython3.10.so /usr/lib/libpython3.11.so
    fi
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# Function to clone dotfiles repository
clone_dotfiles_repository() {
    git clone https://github.com/tripleseven190504/dotfiles ~/dotfiles
}

# Function to configure git
configure_git() {
    git config --global user.email "tripleseven190504@gmail.com"
    git config --global user.name "Tuấn Anh"
}

# Main script execution
configure_pacman
install_pacman_packages
install_yay_and_aur_packages
install_oh_my_zsh
clone_dotfiles_repository
configure_git
