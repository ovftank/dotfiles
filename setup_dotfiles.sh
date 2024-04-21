#!/bin/bash

# Function to clone dotfiles repository
clone_dotfiles_repository() {
    echo "Cloning dotfiles repository..."
    git clone https://github.com/tripleseven190504/dotfiles ~/dotfiles || { echo "Failed to clone dotfiles repository"; exit 1; }
    mv "$HOME"/dotfiles/home "$HOME"/dotfiles/"$USER"
    cp -a "$HOME"/dotfiles/"$USER" /home || { echo "Failed to copy dotfiles"; exit 1; }
    echo "Dotfiles cloned successfully."
}

# Function to install yay and AUR packages
install_yay_and_aur_packages() {
    echo "Installing yay and AUR packages..."
    if ! command -v yay &>/dev/null; then
        git clone https://aur.archlinux.org/yay.git || { echo "Failed to clone yay repository"; exit 1; }
        cd yay || { echo "Failed to enter yay directory"; exit 1; }
        makepkg -si --noconfirm || { echo "Failed to install yay"; exit 1; }
        rm -rf yay
    fi
    yay -S downgrade visual-studio-code-bin google-chrome ibus-bamboo --noconfirm || { echo "Failed to install AUR packages"; exit 1; }
    downgrade -y python || { echo "Failed to downgrade Python"; exit 1; }
    python -m ensurepip --upgrade || { echo "Failed to upgrade pip"; exit 1; }
    sudo pacman -S telegram-desktop lxappearance-gtk3 -y || { echo "Failed to install pacman packages"; exit 1; }
    sudo ln -s /usr/lib/libpython3.10.so /usr/lib/libpython3.11.so.1.0
    sudo ln -s /usr/lib/libpython3.10.so /usr/lib/libpython3.11.so
    echo "Yay and AUR packages installed successfully."
}

# Function to install pacman packages
install_pacman_packages() {
    echo "Installing pacman packages..."
    sudo pacman -Syyu || { echo "Failed to update system"; exit 1; }
    sudo pacman -S wakatime pcmanfm xarchiver unzip zip php i3-wm xorg-server xorg-xinit acpi feh php alacritty zsh git ttf-jetbrains-mono-nerd zsh-syntax-highlighting maim xclip rofi pulseaudio polybar --needed --noconfirm || { echo "Failed to install pacman packages"; exit 1; }
    sudo pacman -S --needed git go --noconfirm || { echo "Failed to install git and go"; exit 1; }
    echo "Pacman packages installed successfully."
}

# Function to configure git
configure_git() {
    echo "Configuring git..."
    git config --global user.email "tripleseven190504@gmail.com" || { echo "Failed to configure git email"; exit 1; }
    git config --global user.name "Tuấn Anh" || { echo "Failed to configure git username"; exit 1; }
    echo "Git configured successfully."
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended || { echo "Failed to install Oh My Zsh"; exit 1; }
    echo "Oh My Zsh installed successfully."
}

# Main script
clone_dotfiles_repository &&
install_yay_and_aur_packages &&
install_pacman_packages &&
configure_git &&
install_oh_my_zsh ||
{ echo "Installation failed"; exit 1; }
