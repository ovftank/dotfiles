#!/bin/sh
set -eu

cd "$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"

KITTY_APP="$HOME/.local/kitty.app"
KITTY_ICON_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"
FONT_DIR="$HOME/.local/share/fonts/JetBrainsMonoNF"
FONT_TTF="$FONT_DIR/JetBrainsMonoNLNerdFont-Regular.ttf"
NODE_LTS_LINE="krypton"

sudo -v || exit 1

sudo apt-get install -y ibus ibus-unikey

if command -v gsettings >/dev/null 2>&1; then
	gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Unikey')]"
	gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Control>alt_L']"
	gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Control>alt_R']"
fi

sudo apt-get install -y stow git curl wget xclip

ripgrep_tag=$(curl -sIL -o /dev/null -w '%{url_effective}' \
	https://github.com/BurntSushi/ripgrep/releases/latest | sed 's#.*/tag/##')
case "$ripgrep_tag" in
v[0-9]* | [0-9]*) ;;
*) exit 1 ;;
esac
ripgrep_version=${ripgrep_tag#v}
ripgrep_installed=$(rg --version 2>/dev/null | head -1 | awk '{print $2}')
if [ "$ripgrep_installed" != "$ripgrep_version" ]; then
	ripgrep_deb=$(mktemp --suffix=.deb)
	curl -fsSL -o "$ripgrep_deb" \
		"https://github.com/BurntSushi/ripgrep/releases/download/$ripgrep_tag/ripgrep_${ripgrep_version}-1_amd64.deb"
	sudo dpkg -i "$ripgrep_deb"
fi

fd_tag=$(curl -sIL -o /dev/null -w '%{url_effective}' \
	https://github.com/sharkdp/fd/releases/latest | sed 's#.*/tag/##')
case "$fd_tag" in
v[0-9]* | [0-9]*) ;;
*) exit 1 ;;
esac
fd_version=${fd_tag#v}
fd_installed=$(fd --version 2>/dev/null | head -1 | awk '{print $2}')
if [ "$fd_installed" != "$fd_version" ]; then
	fd_deb=$(mktemp --suffix=.deb)
	curl -fsSL -o "$fd_deb" \
		"https://github.com/sharkdp/fd/releases/download/$fd_tag/fd_${fd_version}_amd64.deb"
	sudo apt-get install -y "$fd_deb"
fi

zoxide_tag=$(curl -sIL -o /dev/null -w '%{url_effective}' \
	https://github.com/ajeetdsouza/zoxide/releases/latest | sed 's#.*/tag/##')
case "$zoxide_tag" in
v[0-9]* | [0-9]*) ;;
*) exit 1 ;;
esac
zoxide_version=${zoxide_tag#v}
zoxide_installed=$(zoxide --version 2>/dev/null | awk '{print $2}')
if [ "$zoxide_installed" != "$zoxide_version" ]; then
	zoxide_deb=$(mktemp --suffix=.deb)
	curl -fsSL -o "$zoxide_deb" \
		"https://github.com/ajeetdsouza/zoxide/releases/download/$zoxide_tag/zoxide_${zoxide_version}-1_amd64.deb"
	sudo dpkg -i "$zoxide_deb"
fi

font_tag=$(curl -sIL -o /dev/null -w '%{url_effective}' \
	https://github.com/ryanoasis/nerd-fonts/releases/latest | sed 's#.*/tag/##')
case "$font_tag" in
v[0-9]* | [0-9]*) ;;
*) exit 1 ;;
esac
font_version=${font_tag#v}
font_installed=$(tr -d '\000' 2>/dev/null <"$FONT_TTF" |
	grep -o 'Nerd Fonts [0-9.]*' | head -1 | awk '{print $3}')
if [ "$font_installed" != "$font_version" ]; then
	font_archive=$(mktemp --suffix=.tar.xz)
	curl -fsSL -o "$font_archive" \
		"https://github.com/ryanoasis/nerd-fonts/releases/download/$font_tag/JetBrainsMono.tar.xz"
	rm -rf "$FONT_DIR"
	mkdir -p "$FONT_DIR"
	tar -xf "$font_archive" -C "$FONT_DIR"
	rm -f "$font_archive"
	fc-cache -f >/dev/null
fi

NVM_DIR="$HOME/.nvm"
NODE_LTS="$NODE_LTS_LINE"
export NVM_DIR NODE_LTS
if [ ! -s "$NVM_DIR/nvm.sh" ]; then
	git clone -q --depth=1 https://github.com/nvm-sh/nvm "$NVM_DIR"
fi
bash -c 'set -e; . "$NVM_DIR/nvm.sh"; nvm install --lts="$NODE_LTS"; nvm alias default "lts/$NODE_LTS"'

export PATH="$HOME/.pi/agent/bin:$PATH"
if [ ! -x "$HOME/.pi/agent/bin/pi" ]; then
	curl -fsSL https://pi.dev/install.sh | sh
fi

if [ ! -x "$HOME/.local/bin/uv" ]; then
	curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
fi

if dpkg -s kitty >/dev/null 2>&1; then
	sudo apt-get remove -y kitty
fi

if [ ! -x "$KITTY_APP/bin/kitty" ]; then
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n
fi
ln -sf "$KITTY_APP/bin/kitty" "$KITTY_APP/bin/kitten" "$HOME/.local/bin/"

mkdir -p "$KITTY_ICON_DIR"
cp -f "$KITTY_APP/share/icons/hicolor/256x256/apps/kitty.png" "$KITTY_ICON_DIR/kitty.png"
gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true

for desktop_file in kitty.desktop kitty-open.desktop; do
	desktop_source="$KITTY_APP/share/applications/$desktop_file"
	[ -f "$desktop_source" ] || continue
	sed "s|^Exec=kitty|Exec=env GLFW_IM_MODULE=ibus $KITTY_APP/bin/kitty|; /^StartupWMClass=/d" \
		"$desktop_source" >"$HOME/.local/share/applications/$desktop_file"
	printf 'StartupWMClass=kitty\n' >>"$HOME/.local/share/applications/$desktop_file"
done
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true

stow --target="$HOME" --ignore='setup\.sh' --ignore='\.git' .
