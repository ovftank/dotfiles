git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~
sudo pacman -Syyu
sudo pacman -S zsh
sudo pacman -S zsh-syntax-highlighting
sudo pacman -S neofetch
yay -S nerd-fonts-source-code-pro
sudo pacman -S noto-fonts
sudo pacman -S i3-gaps
sudo pacman -S i3blocks
sudo pacman -S terminator
sudo pacman -S xclip
sudo pacman -S maim
sudo pacman -S dmenu
sudo pacman -S lxappearance
sudo pacman -S pcmanfm
yay -S google-chrome
yay -S ibus-unikey
sudo pacman -Rsucn pulseaudio
sudo pacman -S alsa-utils
sudo gpasswd -a $(/usr/bin/users) audio

sudo rm -rf ~/.config/i3
sudo rm -rf ~/.config/i3blocks
sudo rm -rf ~/.config/terminator
sudo rm -rf ~/.config/neofetch
sudo rm -rm ~/.config/nvim
sudo rm -rf ~/.icons/
sudo rm -rf ~/.themes/
sudo rm -rf ~/.zshrc
sudo rm -rf ~/.oh-my-zsh/themes
sudo rm -rf ~/.oh-my-zsh/lib
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp -r ~/dotfiles/.config ~/
cp -r ~/dotfiles/.themes ~/
cp -r ~/dotfiles/.icons ~/
cp -r ~/dotfiles/.zshrc ~/
cp -r ~/dotfiles/.oh-my-zsh ~/
cp -r ~/dotfiles/.oh-my-zsh/lib ~/.oh-my-zsh/themes
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sudo rm /etc/X11/xinit/xinitrc
sudo cp dotfiles/xinit/xinitrc /etc/X11/xinit/xinitrc
sudo cp -r dotfiles/xorg.conf.d /etc/X11/
curl -sL install-node.vercel.app/lts | bash
sudo pacman -Sc
rm -rf ~/dotfiles
