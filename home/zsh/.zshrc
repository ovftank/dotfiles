# Export ZSH variable
export ZSH="$HOME/.oh-my-zsh"

# Set QT_QPA_PLATFORMTHEME
export QT_QPA_PLATFORMTHEME=gnome

# Set ZSH_THEME
export ZSH_THEME="dracula"

# Bindkeys
bindkey "^q" beginning-of-line
bindkey "^e" end-of-line

# Additional aliases
alias ssh='TERM=xterm-256color ssh'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cls='clear'
alias -s txt=code
alias -s py=python
alias -s js=node

# Export Input Method variables
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# Plugins
export plugins=(git gitfast history)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autoload and source Oh My Zsh
autoload -U compinit && compinit
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Export QT_QPA_PLATFORM
export QT_QPA_PLATFORM=xcb

# Add new path to PATH
export PATH="${PATH:+${PATH}:}/home/$USER/.local/bin"
