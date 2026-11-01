#!/bin/sh
set -eu

cd "$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"

KITTY_APPLICATION_DIRECTORY="$HOME/.local/kitty.app"
KITTY_SHARE_DIRECTORY="$KITTY_APPLICATION_DIRECTORY/share"
KITTY_ICON_DIRECTORY="$HOME/.local/share/icons/hicolor/256x256/apps"
FONT_DIRECTORY="$HOME/.local/share/fonts/JetBrainsMonoNF"
FONT_VERSION_SOURCE="$FONT_DIRECTORY/JetBrainsMonoNLNerdFont-Regular.ttf"
NODE_LTS_NAME="krypton"

get_latest_release_tag() {
	release_tag=$(curl -sIL -o /dev/null -w '%{url_effective}' \
		"https://github.com/$1/releases/latest" | sed 's#.*/tag/##')
	case "$release_tag" in
	v[0-9]* | [0-9]*) printf '%s\n' "$release_tag" ;;
	*) return 1 ;;
	esac
}

get_installed_version() {
	"$1" --version 2>/dev/null | head -n 1 | awk '{print $2}'
}

sudo -v || exit 1

sudo apt-get install -y ibus ibus-unikey

if command -v gsettings >/dev/null 2>&1; then
	gsettings set org.gnome.desktop.input-sources sources \
		"[('xkb', 'us'), ('ibus', 'Unikey')]"
	gsettings set org.gnome.desktop.wm.keybindings switch-input-source \
		"['<Control>alt_L']"
	gsettings set \
		org.gnome.desktop.wm.keybindings switch-input-source-backward \
		"['<Control>alt_R']"
fi

sudo apt-get install -y stow git curl wget xclip

repository=BurntSushi/ripgrep
release_tag=$(get_latest_release_tag "$repository")
desired_version=${release_tag#v}
installed_version=$(get_installed_version rg)
if [ "$installed_version" != "$desired_version" ]; then
	download_path=$(mktemp --suffix=.deb)
	download_base_url="https://github.com/$repository/releases/download"
	release_asset="ripgrep_${desired_version}-1_amd64.deb"
	curl -fsSL -o "$download_path" \
		"$download_base_url/$release_tag/$release_asset"
	sudo dpkg -i "$download_path"
fi

repository=sharkdp/fd
release_tag=$(get_latest_release_tag "$repository")
desired_version=${release_tag#v}
installed_version=$(get_installed_version fd)
if [ "$installed_version" != "$desired_version" ]; then
	download_path=$(mktemp --suffix=.deb)
	download_base_url="https://github.com/$repository/releases/download"
	release_asset="fd_${desired_version}_amd64.deb"
	curl -fsSL -o "$download_path" \
		"$download_base_url/$release_tag/$release_asset"
	sudo apt-get install -y "$download_path"
fi

repository=ajeetdsouza/zoxide
release_tag=$(get_latest_release_tag "$repository")
desired_version=${release_tag#v}
installed_version=$(get_installed_version zoxide)
if [ "$installed_version" != "$desired_version" ]; then
	download_path=$(mktemp --suffix=.deb)
	download_base_url="https://github.com/$repository/releases/download"
	release_asset="zoxide_${desired_version}-1_amd64.deb"
	curl -fsSL -o "$download_path" \
		"$download_base_url/$release_tag/$release_asset"
	sudo dpkg -i "$download_path"
fi

repository=zellij-org/zellij
release_tag=$(get_latest_release_tag "$repository")
desired_version=${release_tag#v}
installed_version=$(get_installed_version zellij)
if [ "$installed_version" != "$desired_version" ]; then
	case "$(uname -m)" in
	x86_64) target_architecture=x86_64 ;;
	aarch64 | arm64) target_architecture=aarch64 ;;
	*) echo "unsupported architecture: $(uname -m)" >&2; exit 1 ;;
	esac
	download_path=$(mktemp --suffix=.tar.gz)
	extraction_directory=$(mktemp -d)
	download_base_url="https://github.com/$repository/releases/download"
	release_asset="zellij-no-web-${target_architecture}-unknown-linux-musl.tar.gz"
	curl -fsSL -o "$download_path" \
		"$download_base_url/$release_tag/$release_asset"
	tar -xf "$download_path" -C "$extraction_directory"
	mkdir -p "$HOME/.local/bin"
	install -m 755 "$extraction_directory/zellij" "$HOME/.local/bin/zellij"
	rm -rf "$extraction_directory" "$download_path"
fi

repository=ryanoasis/nerd-fonts
release_tag=$(get_latest_release_tag "$repository")
desired_version=${release_tag#v}
installed_version=$(tr -d '\000' 2>/dev/null <"$FONT_VERSION_SOURCE" |
	grep -o 'Nerd Fonts [0-9.]*' | head -n 1 | awk '{print $3}')
if [ "$installed_version" != "$desired_version" ]; then
	download_path=$(mktemp --suffix=.tar.xz)
	download_base_url="https://github.com/$repository/releases/download"
	curl -fsSL -o "$download_path" \
		"$download_base_url/$release_tag/JetBrainsMono.tar.xz"
	rm -rf "$FONT_DIRECTORY"
	mkdir -p "$FONT_DIRECTORY"
	tar -xf "$download_path" -C "$FONT_DIRECTORY"
	rm -f "$download_path"
	fc-cache -f >/dev/null
fi

export NVM_DIR="$HOME/.nvm" NODE_LTS="$NODE_LTS_NAME"
if [ ! -s "$NVM_DIR/nvm.sh" ]; then
	git clone -q --depth=1 https://github.com/nvm-sh/nvm "$NVM_DIR"
fi
bash -c 'set -e
	. "$NVM_DIR/nvm.sh"
	nvm install --lts="$NODE_LTS"
	nvm alias default "lts/$NODE_LTS"'

export PATH="$HOME/.pi/agent/bin:$PATH"
if [ ! -x "$HOME/.pi/agent/bin/pi" ]; then
	curl -fsSL https://pi.dev/install.sh | sh
fi

if [ ! -x "$HOME/.local/bin/uv" ]; then
	curl -LsSf https://astral.sh/uv/install.sh |
		env UV_NO_MODIFY_PATH=1 sh
fi

if dpkg -s kitty >/dev/null 2>&1; then
	sudo apt-get remove -y kitty
fi

kitty_binary_path="$KITTY_APPLICATION_DIRECTORY/bin/kitty"
if [ ! -x "$kitty_binary_path" ]; then
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh |
		sh /dev/stdin launch=n
fi
ln -sf "$kitty_binary_path" \
	"$KITTY_APPLICATION_DIRECTORY/bin/kitten" "$HOME/.local/bin/"

mkdir -p "$KITTY_ICON_DIRECTORY"
icon_source_path="$KITTY_SHARE_DIRECTORY/icons/hicolor/256x256/apps/kitty.png"
cp -f "$icon_source_path" "$KITTY_ICON_DIRECTORY/kitty.png"
gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null ||
	true

kitty_exec_command="Exec=env GLFW_IM_MODULE=ibus $kitty_binary_path"
for desktop_entry in kitty.desktop kitty-open.desktop; do
	desktop_source_path="$KITTY_SHARE_DIRECTORY/applications/$desktop_entry"
	[ -f "$desktop_source_path" ] || continue
	desktop_target_path="$HOME/.local/share/applications/$desktop_entry"
	sed -e "s|^Exec=kitty|$kitty_exec_command|" -e '/^StartupWMClass=/d' \
		"$desktop_source_path" >"$desktop_target_path"
	printf 'StartupWMClass=kitty\n' >>"$desktop_target_path"
done
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true

stow --target="$HOME" --ignore='setup\.sh' --ignore='\.git' .
