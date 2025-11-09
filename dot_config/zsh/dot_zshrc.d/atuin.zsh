# shellcheck disable=2148,SC2168,SC1090,SC2125

# Defer atuin initialization to speed up shell startup
(( $+commands[atuin] )) || return 0

atuin-setup() {
  bindkey '^E' atuin-search

  export ATUIN_NOBIND="true"
  eval "$(atuin init zsh)"

  fzf-atuin-history-widget() {
    local selected num
    setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2>/dev/null
    selected=$(atuin search --cmd-only --limit ${ATUIN_LIMIT:-5000} | tac |
      FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS --query=${LBUFFER} +m" fzf)
    local ret=$?
    if [ -n "$selected" ]; then
      LBUFFER+="${selected}"
    fi
    zle -U "$selected"
    zle kill-buffer
    zle reset-prompt
    return $ret
  }
  zle -N fzf-atuin-history-widget
  bindkey '^R' fzf-atuin-history-widget
}

# Initialize atuin lazily
autoload -Uz add-zsh-hook
add-zsh-hook precmd atuin-setup

