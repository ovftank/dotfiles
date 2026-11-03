#compdef zellij

_zellij() {
    local -a sessions
    local subcommand=${words[2]}

    if (( CURRENT == 3 )); then
        case $subcommand in
        attach | a | watch | w | kill-session | k | delete-session | d)
            sessions=(${(f)"$(zellij list-sessions --short 2>/dev/null)"})
            sessions=(${sessions:#No active zellij sessions found.})
            if (( ${#sessions} )); then
                _describe -t sessions 'zellij session' sessions
            fi
            return
            ;;
        esac
    fi

    (( $+functions[_zellij_clap] )) || autoload -Uz _zellij_clap
    _zellij_clap "$@"
}

compdef _zellij zellij
