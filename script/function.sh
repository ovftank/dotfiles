RETURN=""
osCheck(){
	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		OSCHECK=`cat /etc/*-release | grep ID=arch`
		if [ $OSCHECK ]
		then
			RETURN="Linux-GNU OS discovered: Arch Linux"
		else
			RETURN="GNU/Linux has been detected"
		fi
	else
		echo "Operating system incompatibility"
		echo "Press any key to exit ...."
		read
		exit
	fi
	echo "$RETURN"
}

aur(){
	cd ~
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si
	cd ~
	rm -rf yay
}

packageIstall(){
	if [[ "$RETURN" == "Linux-GNU OS discovered: Arch Linux" ]]; then
		aur
		sudo pacman -Syyu i3-gaps i3blocks noto-fonts terminator zsh ripgrep bat neofetch pulseaudio dmenu feh maim xclip python3 python-pip stylua --noconfirm
		yay -S google-chrome ibus-bamboo nerd-fonts-source-code-pro pulseaudio-ctl --noconfirm
		clear
	elif [[ "$RETURN" == "GNU/Linux has been detected" ]]; then
		sudo apt update&&sudo apt upgrade
		curl -sL install-node-=.vercel.app/lts | sh
		sudo apt install --yes zsh terminator i3wm i3blocks pcmanfm dmenu feh pulseaudio xclip python3 lxappearance google-chrome-stable pulseaudio-ctl
		clear
		echo "I'm using only Arch Linux/Manjaro, so i'm not sure other distro can work fine with this script"
	else
		echo "=)), maybe script have some bugs,pls report to tgbiztank"
	fi
}

finish(){
	echo -ne '\n' | python3 -m pip install pynvim
	sudo gpasswd -a$(/usr/bin/users) audio
	chsh -s $(which zsh)

	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	cd ~/dotfiles
	
	mv ~/dotfiles/homefolder $(/bin/users)

	cp -r ~/dotfiles/$(/bin/users) /home/

	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

	chsh -s $(which zsh)

	sudo cp -r ~/dotfiles/X11 /etc/
	}
