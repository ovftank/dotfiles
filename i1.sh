#install recommend package
sudo pacman -Syyu 			#sync and update package
sudo pacman -S dmenu 		#install dmenu(Ctrl+F)
sudo pacman -S feh 			#wallpaper
sudo pacman -S i3blocks 	#status bar
sudo pacman -S i3-gaps 		#windows manager
sudo pacman -S lxappearance #themes options
sudo pacman -S maim 		#screen capture
sudo pacman -S neofetch 	#show OS info
sudo pacman -S noto-fonts 	#font for zsh
sudo pacman -S pcmanfm 		#explorer
# sudo pacman -S picom 		#add transparent
sudo pacman -S pulseaudio 	#install audio daemon
sudo pacman -S terminator 	#terminal
sudo pacman -S xclip 		#active clipboard for maim and nvim
sudo pacman -S zsh 			#zsh
sudo pacman -S zsh-syntax-highlighting
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#install yay(AUR)
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~
rm -rf yay

yay -S nerd-fonts-source-code-pro 			#font forstatusbar
yay -S ibus-bamboo 				  			#vietnamese typing
yay -S google-chrome 			  			#browser
yay -S pulseaudio-ctl 						#install audio control with shortcut
sudo gpasswd -a $(/usr/bin/users) audio 	#add user to audio group

#delete old config
sudo rm -rf ~/.config/i3
sudo rm -rf ~/.config/i3blocks
sudo rm -rf ~/.config/neofetch
sudo rm -rm ~/.config/nvim
sudo rm -rf ~/.config/terminator

sudo rm /etc/X11/xinit/xinitrc

sudo rm -rf ~/.icons/
sudo rm -rf ~/.themes/

sudo rm -rf ~/.zshrc
sudo rm -rf ~/.oh-my-zsh/lib
sudo rm -rf ~/.oh-my-zsh/themes

#copy dotfiles
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cp -r ~/dotfiles/.config ~/

sudo cp -r dotfiles/xorg.conf.d /etc/X11/
sudo cp dotfiles/xinit/xinitrc /etc/X11/xinit/xinitrc

cp -r ~/dotfiles/.icons ~/
cp -r ~/dotfiles/.themes ~/
cp -r ~/dotfiles/Pictures ~/

cp -r ~/dotfiles/.zshrc ~/
cp -r ~/dotfiles/.oh-my-zsh ~/
cp -r ~/dotfiles/.oh-my-zsh/lib ~/.oh-my-zsh/themes

sudo pacman -Sc
rm -rf ~/dotfiles
