# shellcheck shell=bash
# shellcheck disable=SC1090,SC1091
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

if ! shopt -oq posix && [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) PATH="$HOME/.local/bin:$PATH" ;;
esac

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

case ":$PATH:" in
    *":$HOME/.pi/agent/bin:"*) ;;
    *) PATH="$PATH:$HOME/.pi/agent/bin" ;;
esac

eval "$(zoxide init bash --cmd cd)"

__zoxide_cd_complete() {
    _cd "$@"
    [ "${#COMPREPLY[@]}" -eq 0 ] && __zoxide_z_complete "$@"
    return 0
}
complete -F __zoxide_cd_complete -o filenames -- cd
