#!/bin/sh
set -eu

cd "$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"

KITTY_APPLICATION_DIRECTORY="$HOME/.local/kitty.app"
KITTY_SHARE_DIRECTORY="$KITTY_APPLICATION_DIRECTORY/share"
KITTY_ICON_DIRECTORY="$HOME/.local/share/icons/hicolor/256x256/apps"
FONT_DIRECTORY="$HOME/.local/share/fonts/JetBrainsMonoNF"
FONT_VERSION_SOURCE="$FONT_DIRECTORY/JetBrainsMonoNLNerdFont-Regular.ttf"
NODE_LTS_NAME="krypton"

case "$(uname -m)" in
x86_64) target_architecture=x86_64 ;;
aarch64 | arm64) target_architecture=aarch64 ;;
*) echo "unsupported architecture: $(uname -m)" >&2; exit 1 ;;
esac

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

add_shell_extension() {
	current_list=$(gsettings get org.gnome.shell enabled-extensions |
		sed 's/^@as //')
	case "$current_list" in
	*"'$1'"*) ;;
	*)
		stripped=${current_list#\[}
		stripped=${stripped%\]}
		stripped=$(printf '%s' "$stripped" |
			sed 's/^[[:space:]]*//; s/[[:space:]]*$//')
		if [ -z "$stripped" ]; then
			gsettings set org.gnome.shell enabled-extensions "['$1']"
		else
			gsettings set org.gnome.shell enabled-extensions \
				"[$stripped, '$1']"
		fi
		;;
	esac
}

sudo -v || exit 1

sudo apt-get install -y fcitx5 fcitx5-frontend-all fcitx5-config-qt \
	fcitx5-modules im-config acl python3-qtpy python3-pyqt6 \
	gnome-shell-extension-appindicator python3-dbus

if dpkg -s ibus-unikey >/dev/null 2>&1; then
	sudo apt-get purge -y ibus-unikey
fi

repository=LotusInputMethod/fcitx5-lotus
release_tag=$(get_latest_release_tag "$repository")
desired_version=${release_tag#v}
installed_version=$(dpkg-query -W -f='${Version}' fcitx5-lotus 2>/dev/null |
	cut -d- -f1)
if [ "$installed_version" != "$desired_version" ]; then
	distribution_codename=$(cd / && . /etc/os-release &&
		printf '%s' "$VERSION_CODENAME")
	download_path=$(mktemp --suffix=.deb)
	download_base_url="https://github.com/$repository/releases/download"
	release_asset="fcitx5-lotus_${desired_version}-1_amd64_${distribution_codename}.deb"
	curl -fsSL -o "$download_path" \
		"$download_base_url/$release_tag/$release_asset"
	sudo apt-get install -y "$download_path"
	rm -f "$download_path"
fi

im-config -n fcitx5

# fcitx5 rewrites these with an atomic replace, which would clobber a symlink
fcitx_seed_directory="$PWD/.config/fcitx5"
mkdir -p "$HOME/.config/fcitx5/conf"
for fcitx_seed in config profile conf/lotus.conf; do
	[ -e "$HOME/.config/fcitx5/$fcitx_seed" ] ||
		cp "$fcitx_seed_directory/$fcitx_seed" \
			"$HOME/.config/fcitx5/$fcitx_seed"
done

icon_theme_source="$PWD/.local/share/icons/fcitx-letter"
if [ -d "$icon_theme_source" ]; then
	rm -rf "$HOME/.local/share/icons/fcitx-letter"
	cp -R "$icon_theme_source" "$HOME/.local/share/icons/fcitx-letter"
	gtk-update-icon-cache -f -t "$HOME/.local/share/icons/fcitx-letter" \
		2>/dev/null || true
fi

if command -v gsettings >/dev/null 2>&1; then
	gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"
	gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
	gsettings set \
		org.gnome.desktop.wm.keybindings switch-input-source-backward "[]"

	# libadwaita apps follow color-scheme, legacy GTK/Qt apps need the dark
	# variant of the GTK theme (gsd-xsettings does not map color-scheme).
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

	add_shell_extension 'ubuntu-appindicators@ubuntu.com'

  appindicator_directory=/usr/share/gnome-shell/extensions/ubuntu-appindicators@ubuntu.com
	appindicator_stylesheet="$appindicator_directory/user.css"
	if [ -d "$appindicator_directory" ] &&
		! grep -q 'natural-hpadding: 6px' \
			"$appindicator_stylesheet" 2>/dev/null; then
		sudo tee "$appindicator_stylesheet" >/dev/null <<'CSS'
#panel .panel-button {
    -natural-hpadding: 6px;
    -minimum-hpadding: 4px;
}
CSS
		gnome-extensions disable ubuntu-appindicators@ubuntu.com \
			2>/dev/null || true
		gnome-extensions enable ubuntu-appindicators@ubuntu.com \
			2>/dev/null || true
	fi

	icon_theme=$(gsettings get org.gnome.desktop.interface icon-theme |
		tr -d "'")
	case "$icon_theme" in
	Adwaita | fcitx-letter)
		gsettings set org.gnome.desktop.interface icon-theme \
			fcitx-letter
		;;
	esac

	gsettings set org.gnome.desktop.default-applications.terminal exec \
		"$HOME/.local/bin/kitty"
	gsettings set org.gnome.desktop.default-applications.terminal exec-arg ''

	kitty_keybinding_path='/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/'
	gsettings set \
		org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$kitty_keybinding_path" \
		name 'Kitty'
	gsettings set \
		org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$kitty_keybinding_path" \
		command "$HOME/.local/bin/kitty"
	gsettings set \
		org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$kitty_keybinding_path" \
		binding '<Control><Alt>t'
	gsettings set org.gnome.settings-daemon.plugins.media-keys \
		custom-keybindings "['$kitty_keybinding_path']"
fi

sudo apt-get install -y stow git curl wget xclip zsh \
	zsh-autosuggestions zsh-syntax-highlighting

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

repository=eza-community/eza
release_tag=$(get_latest_release_tag "$repository")
desired_version=${release_tag#v}

installed_version=$("$HOME/.local/bin/eza" --version 2>/dev/null |
	sed -n 2p | awk '{print $1}' | sed 's/^v//')
if [ "$installed_version" != "$desired_version" ]; then
	download_path=$(mktemp --suffix=.tar.gz)
	extraction_directory=$(mktemp -d)
	download_base_url="https://github.com/$repository/releases/download"
	release_asset="eza_${target_architecture}-unknown-linux-gnu.tar.gz"
	curl -fsSL -o "$download_path" \
		"$download_base_url/$release_tag/$release_asset"
	tar -xf "$download_path" -C "$extraction_directory"
	mkdir -p "$HOME/.local/bin"
	install -m 755 "$extraction_directory/eza" "$HOME/.local/bin/eza"
	rm -rf "$extraction_directory" "$download_path"
fi

repository=starship/starship
release_tag=$(get_latest_release_tag "$repository")
desired_version=${release_tag#v}
installed_version=$(get_installed_version starship)
if [ "$installed_version" != "$desired_version" ]; then
	download_path=$(mktemp --suffix=.tar.gz)
	extraction_directory=$(mktemp -d)
	download_base_url="https://github.com/$repository/releases/download"
	release_asset="starship-${target_architecture}-unknown-linux-gnu.tar.gz"
	curl -fsSL -o "$download_path" \
		"$download_base_url/$release_tag/$release_asset"
	tar -xf "$download_path" -C "$extraction_directory"
	mkdir -p "$HOME/.local/bin"
	install -m 755 "$extraction_directory/starship" "$HOME/.local/bin/starship"
	rm -rf "$extraction_directory" "$download_path"
fi

starship_version=$(get_installed_version starship)
starship_cache_file="$HOME/.cache/starship/init.zsh"
starship_cache_stamp="$HOME/.cache/starship/.version"
if [ -n "$starship_version" ] && [ "$(cat "$starship_cache_stamp" 2>/dev/null)" != "$starship_version" ]; then
	mkdir -p "${starship_cache_file%/*}"
	starship init zsh >"$starship_cache_file"
	printf '%s\n' "$starship_version" >"$starship_cache_stamp"
fi

if [ "$(getent passwd "$(id -un)" | cut -d: -f7)" != "/usr/bin/zsh" ]; then
	sudo chsh -s /usr/bin/zsh "$(id -un)"
fi

zsh_completion_directory="$HOME/.local/share/zsh/site-functions"
zellij_installed_version=$(get_installed_version zellij)
zellij_completion_stamp="$zsh_completion_directory/.zellij-$zellij_installed_version"
mkdir -p "$zsh_completion_directory"
if [ ! -f "$zellij_completion_stamp" ]; then
	zellij setup --generate-completion zsh 2>/dev/null | awk '
		NR == 1 && /^#compdef/ { next }
		index($0, "if [ \"$funcstack[1]\" = \"_zellij\" ]; then") == 1 { skip = 1; next }
		skip && $0 == "fi" { skip = 0; next }
		!skip { print }
	' | sed 's/^_zellij() {$/_zellij_clap() {/' >"$zsh_completion_directory/_zellij_clap"
	rm -f "$zsh_completion_directory"/.zellij-*
	: >"$zellij_completion_stamp"
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

mkdir -p "$HOME/.local/bin" "$HOME/.local/share/applications"
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true

if [ -x "$HOME/.local/bin/kitty" ]; then
	sudo update-alternatives --install /usr/bin/x-terminal-emulator \
		x-terminal-emulator "$HOME/.local/bin/kitty" 50
	sudo update-alternatives --set x-terminal-emulator "$HOME/.local/bin/kitty"
fi

stow --target="$HOME" --ignore='setup\.sh' --ignore='\.git' --ignore='\.local' \
	--ignore='\.config/fcitx5' .

sudo systemctl enable --now "fcitx5-lotus-server@$(id -un).service"
