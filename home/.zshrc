source ~/.oh-my-zsh/custom/plugins/zsh-snap/znap.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
export VISUAL=/usr/bin/nvim 
export EDITOR=/usr/bin/nvim
plugins=(git)
ENABLE_CORRECTION="true"

source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi
#keybind
bindkey "^q" beginning-of-line
bindkey "^e" end-of-line

bindkey "^[j" down-line-or-history
bindkey "^[k" up-line-or-history 
bindkey "^[h" backward-char
bindkey "^[l" forward-char

bindkey "^[OA" neg-argument
bindkey "^[OB" neg-argument
bindkey "^[OC" neg-argument
bindkey "^[OD" neg-argument

bindkey "^a" neg-argument

#plugins
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

bindkey "^p" autosuggest-accept
bindkey "^g" autosuggest-fetch

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=#6272A4'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[function]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[command]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#50FA7B,italic'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#FFB86C,italic'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#FFB86C'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#FFB86C'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#BD93F9'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#8BE9FD'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#8BE9FD'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#8BE9FD'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#F1FA8C'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#F1FA8C'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#F1FA8C'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#F1FA8C'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#F1FA8C'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[path]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#BD93F9'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[default]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[cursor]='standout'

if [ "$TERM" = "linux" ]; then
  printf %b '\e[40m' '\e[8]' # set default background to color 0 'dracula-bg'
  printf %b '\e[37m' '\e[8]' # set default foreground to color 7 'dracula-fg'
  printf %b '\e]P0282a36'    # redefine 'black'          as 'dracula-bg'
  printf %b '\e]P86272a4'    # redefine 'bright-black'   as 'dracula-comment'
  printf %b '\e]P1ff5555'    # redefine 'red'            as 'dracula-red'
  printf %b '\e]P9ff7777'    # redefine 'bright-red'     as '#ff7777'
  printf %b '\e]P250fa7b'    # redefine 'green'          as 'dracula-green'
  printf %b '\e]PA70fa9b'    # redefine 'bright-green'   as '#70fa9b'
  printf %b '\e]P3f1fa8c'    # redefine 'brown'          as 'dracula-yellow'
  printf %b '\e]PBffb86c'    # redefine 'bright-brown'   as 'dracula-orange'
  printf %b '\e]P4bd93f9'    # redefine 'blue'           as 'dracula-purple'
  printf %b '\e]PCcfa9ff'    # redefine 'bright-blue'    as '#cfa9ff'
  printf %b '\e]P5ff79c6'    # redefine 'magenta'        as 'dracula-pink'
  printf %b '\e]PDff88e8'    # redefine 'bright-magenta' as '#ff88e8'
  printf %b '\e]P68be9fd'    # redefine 'cyan'           as 'dracula-cyan'
  printf %b '\e]PE97e2ff'    # redefine 'bright-cyan'    as '#97e2ff'
  printf %b '\e]P7f8f8f2'    # redefine 'white'          as 'dracula-fg'
  printf %b '\e]PFffffff'    # redefine 'bright-white'   as '#ffffff'
  clear
fi
#Some alias...
alias fb="i3-msg exec xdg-open https://www.facebook.com >> /dev/null"
alias gg="i3-msg exec sh ~/.config/i3/script/gg.sh >> /dev/null"
alias gh="i3-msg exec sh ~/.config/i3/script/gh.sh >> /dev/null"
# alias jav="i3-msg exec 'google-chrome-stable -incognito javhd.onl'&&i3-msg kill"
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
neofetch
