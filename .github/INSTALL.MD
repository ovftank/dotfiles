# INSTALL.MD

## 1. Hàm `install_packages`

- `alacritty`: Một terminal... xịn, cross platform
- `zsh`: Ngon hơn bash =)))
- `git`: Tất nhiên rồi
- `ttf-jetbrains-mono-nerd`: Font này cũng đỉnh, xem [Preview ở đây](https://www.programmingfonts.org/#jetbrainsmono)
- `telegram-desktop`: Telegram, thích thì cài, không thích thì cài =)))
- `zsh-syntax-highlighting`: Đúng như cái tên của nó, syntax-highlight cú pháp trong terminal!

```bash
sudo pacman -S alacritty zsh git ttf-jetbrains-mono-nerd telegram-desktop zsh-syntax-highlighting --needed --noconfirm
```

## 2. Hàm `check_and_install_yay`

- `downgrade`: được sử dụng để rollback `python` về phiên bản `3.10.10`(mình thích =))), không có cũng không sao)

- `visual-studio-code-bin`: Text Editor

- `google-chrome`:Trình duyệt, mình thích Chrome hơn Linux :>

- `ibus-bamboo`: bộ gõ tiếng Việt

- `normcap`: `OCR` văn bản trên màn hình

  ```bash
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
  ```

## 3. Hàm `load_config_gnome`

```bash
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

```

## 4. Hàm `install_oh_my_zsh`

```bash
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    sudo chsh --shell "$(which zsh)" "$USER"
```

## 5. Hàm `clone_dotfiles`

```bash
    git clone https://github.com/tripleseven190504/dotfiles ~/dotfiles
    cp ~/dotfiles/home/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
    cp -r ~/dotfiles/home/ibus-bamboo ~/.config/
    cp ~/dotfiles/home/burn-my-windows/*.conf ~/.config/burn-my-windows/
    cp ~/dotfiles/home/pip/pip.conf ~/.config/pip/pip.conf
    cp ~/dotfiles/home/zsh/.zshrc ~/.zshrc
    cp ~/dotfiles/home/zsh/dracula_theme/* ~/.oh-my-zsh/themes/
    cp ~/dotfiles/home/wakatime/wakatime.cfg ~/.wakatime.cfg
```

## 6. Hàm `configure_git`

```bash
    git config --global user.email "tripleseven190504@gmail.com"
    git config --global user.name "Tuấn Anh"
```
