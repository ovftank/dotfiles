#!/bin/bash

function package_manager_check() {
  if [ -x "$(command -v apt-get)" ]; then
    echo "apt-get"
  elif [ -x "$(command -v pacman)" ]; then
    echo "pacman"
  else
    echo "OS not supported"
  fi
}

package_manager=$(package_manager_check)

package_install() {
  if [ "$package_manager" == "apt-get" ]; then
    sudo apt-get install bat dmenu feh gcc go i3-gaps i3blocks maim make neofetch nodejs-lts-gallium noto-fonts npm pulseaudio python-pip ripgrep terminator xclip zsh -y
  elif [ "$package_manager" == "pacman" ]; then
    # install some packages needed for this dotfiles
    sudo pacman -Syyu bat dmenu feh gcc go i3-gaps i3blocks maim make neofetch nodejs-lts-gallium noto-fonts npm pulseaudio python-pip ripgrep terminator xclip zsh --noconfirm

    yay_install() {
      git clone https://aur.archlinux.org/yay.git
      cd yay
      makepkg -si --noconfirm
      cd ..
      rm -rf yay
    } 
    # install yay from AUR
    yay_install
    # install packages from AUR
    yay -S google-chrome ibus-bamboo nerd-fonts-space-mono pulseaudio-ctl --noconfirm

    package_uninstall() {
      sudo pacman -Rsucn cmake gc go gcc gzip yay --noconfirm
    }
    # uninstall the packages that are not needed anymore
    package_uninstall
  else
    echo "$package_manager"
  fi
}

configure(){
  python3 -m pip install pynvim > /dev/null 2>&1
  sudo gpasswd -a$(/usr/bin/users) audio > /dev/null 2>&1
  chsh -s $(which zsh)
}

install_dotfiles() {
  # install dotfiles
  git clone https://github.com/tgbiztank/dotfiles.git
  cd dotfiles
  cp -r home/. ~/
  sudo cp -r root/. /
  cd ..
  rm -rf dotfiles
  sudo echo "GRUB_THEME="/boot/grub/themes/dracula/theme.txt"" >> /etc/default/grub
  sudo grub-mkconfig -o /boot/grub/grub.cfg
}

function main() {
  package_install
  configure
  install_dotfiles
  clear
  echo "Dotfiles installed!"
}

main
