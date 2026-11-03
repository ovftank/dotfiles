fpath=(~/.local/share/zsh/site-functions $fpath)

zmodload zsh/stat zsh/datetime 2>/dev/null
autoload -Uz compinit
_zcompdump=${ZDOTDIR:-$HOME}/.zcompdump
_zrebuild=0
if zstat -A _zm +mtime -- "$_zcompdump" 2>/dev/null; then
    ((EPOCHSECONDS - _zm[1] >= 86400)) && _zrebuild=1
    for _zf in ~/.local/share/zsh/site-functions/*(N); do
        if zstat -A _zfst +mtime -- "$_zf" 2>/dev/null && ((_zfst[1] > _zm[1])); then
            _zrebuild=1
            break
        fi
    done
else
    _zrebuild=1
fi
unset _zf _zfst _zm
if ((_zrebuild)); then
    compinit -d "$_zcompdump"
    zcompile "$_zcompdump" 2>/dev/null
    touch "$_zcompdump"
else
    compinit -C -d "$_zcompdump"
fi
unset _zcompdump _zrebuild

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
eval "$(dircolors -b 2>/dev/null)"
[ -n "$LS_COLORS" ] && zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

[ -r ~/.config/zsh/zellij.zsh ] && source ~/.config/zsh/zellij.zsh

bindkey -e

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_ignore_all_dups hist_ignore_space append_history inc_append_history share_history

_starship_init_cache=~/.cache/starship/init.zsh
if [ -r "$_starship_init_cache" ] &&
    { [ ! -x "$commands[starship]" ] || [ "$_starship_init_cache" -nt "$commands[starship]" ]; }; then
    source "$_starship_init_cache"
elif command -v starship >/dev/null; then
    eval "$(starship init zsh)"
fi
unset _starship_init_cache
precmd() { print -Pn '\e]0;%n@%m: %~\a' }
setopt interactive_comments

if [ -r /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#565f89'

    ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=()
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if command -v eza >/dev/null; then
    alias ls='eza --icons=auto --group-directories-first'
    alias ll='eza -l --icons=auto --group-directories-first --git --time-style=long-iso'
    alias la='eza -la --icons=auto --group-directories-first --git'
    alias lt='eza --tree --level=2 --icons=auto'
fi

case ":$PATH:" in
*":$HOME/.local/bin:"*) ;;
*) PATH="$HOME/.local/bin:$PATH" ;;
esac

export NVM_DIR="$HOME/.nvm"
_nvm_load() {
    unfunction nvm node npm npx pnpm yarn corepack 2>/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}
nvm() { _nvm_load; nvm "$@"; }
node() { _nvm_load; node "$@"; }
npm() { _nvm_load; npm "$@"; }
npx() { _nvm_load; npx "$@"; }
pnpm() { _nvm_load; pnpm "$@"; }
yarn() { _nvm_load; yarn "$@"; }
corepack() { _nvm_load; corepack "$@"; }

case ":$PATH:" in
*":$HOME/.pi/agent/bin:"*) ;;
*) PATH="$PATH:$HOME/.pi/agent/bin" ;;
esac

if command -v zoxide >/dev/null; then
    eval "$(zoxide init zsh --cmd cd)"
fi

command -v fzf >/dev/null && source <(fzf --zsh)

clear() {
    command clear
    printf '\033[3J'
}

: "${EDITOR:=nvim}"
: "${VISUAL:=$EDITOR}"
export EDITOR VISUAL

bindkey '^[^?' backward-kill-word

bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

[ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
