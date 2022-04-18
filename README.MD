# Preview
# <img src="https://raw.githubusercontent.com/goMb1z/dotfiles/main/image.png">

# Installation

```
cd ~
git clone https://github.com/goMb1z/dotfiles.git
cd dotfiles
sudo chmod +x install.sh
./install.sh
rm -rf ~/dotfiles
sudo -i
curl -sL install-node.vercel.app/lts | bash
exit
exit
```
### I love minimalism.
But if you want to use wallpaper and add transparency. Let's run the following commands:
```
sudo pacman -S feh
sudo pacman -S picom
rm ~/.config/i3/config
mv ~/dotfiles/.config/i3/config2 ~/.config/i3/config
```
##
