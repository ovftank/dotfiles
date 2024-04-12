#!/bin/bash

install_packages() {
    echo "Color" | sudo tee -a /etc/pacman.conf
    echo "IgnorePkg   = python" | sudo tee -a /etc/pacman.conf
    sudo pacman -S alacritty zsh git ttf-jetbrains-mono-nerd telegram-desktop zsh-syntax-highlighting --needed --noconfirm
    sudo pacman -S --needed git go --noconfirm
}

check_and_install_yay() {
    if ! command -v yay &>/dev/null; then
        git clone https://aur.archlinux.org/yay.git
        cd yay || exit
        makepkg -si
    else
        yay -S downgrade visual-studio-code-bin google-chrome ibus-bamboo normcap --noconfirm
        downgrade -y python
        python -m ensurepip --upgrade
        sudo ln -s /usr/lib/libpython3.10.so /usr/lib/libpython3.11.so.1.0
        sudo ln -s /usr/lib/libpython3.10.so /usr/lib/libpython3.11.so
    fi
}

load_config_gnome() {
    cd ~/dotfiles/home/gnome || exit
    mv -f ~/dotfiles/home/gnome/extensions/ ~/.local/share/gnome-shell/
    dconf load / ~/dotfiles/home/gnome/gnome_settings.dconfE
    mkdir -p ~/.config/wallpapers
    background_path="$HOME"/.config/wallpapers/wallpaper.png
    cp ~/dotfiles/home/gnome/backgrounds/wallpaper.png ~/.config/wallpapers/wallpaper.png
    if [[ "$(identify -verbose "$background_path" | grep Colorspace)" == *"Gray"* ]]; then
        color_mode="dark"
    else
        color_mode="light"
    fi
    gsettings set org.gnome.desktop.screensaver picture-uri "file://$background_path"
    gsettings set org.gnome.desktop.screensaver picture-uri-$color_mode "file://$background_path"
    gsettings set org.gnome.desktop.background picture-uri "file://$background_path"
    gsettings set org.gnome.desktop.background picture-uri-$color_mode "file://$background_path"
}

install_oh_my_zsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    sudo chsh --shell "$(which zsh)" "$USER"
}

clone_dotfiles() {
    git clone https://github.com/tripleseven190504/dotfiles ~/dotfiles
}

copy_dotfiles() {
    cp ~/dotfiles/home/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
    cp -r ~/dotfiles/home/ibus-bamboo ~/.config/
    cp ~/dotfiles/home/burn-my-windows/*.conf ~/.config/burn-my-windows/
    cp ~/dotfiles/home/pip/pip.conf ~/.config/pip/pip.conf
    cp ~/dotfiles/home/zsh/.zshrc ~/.zshrc
    cp ~/dotfiles/home/zsh/dracula_theme/* ~/.oh-my-zsh/themes/
    cp ~/dotfiles/home/wakatime/wakatime.cfg ~/.wakatime.cfg
}

configure_git() {
    git config --global user.email "tripleseven190504@gmail.com"
    git config --global user.name "Tuấn Anh"
}

install_packages
check_and_install_yay
load_config_gnome
install_oh_my_zsh
clone_dotfiles
copy_dotfiles
configure_git
