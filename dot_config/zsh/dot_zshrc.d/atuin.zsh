# shellcheck disable=2148,SC2168,SC1090,SC2125
local FOUND_ATUIN=$+commands[atuin]

if [[ $FOUND_ATUIN -eq 1 ]]; then
  # ref:
  # - https://gist.github.com/nikvdp/f72ff1776815861c5da78ceab2847be2
  # - https://github.com/atuinsh/atuin/blob/main/atuin.plugin.zsh
  # - https://docs.atuin.sh/configuration/key-binding/#zsh
  atuin-setup() {
    ! hash atuin && return
    bindkey '^E' atuin-search

    export ATUIN_NOBIND="true"
    source <(atuin init zsh)
    fzf-atuin-history-widget() {
      local selected num
      setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2>/dev/null
      selected=$(atuin search --cmd-only --limit ${ATUIN_LIMIT:-5000} | tac |
        FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS --query=${LBUFFER} +m" fzf)
      local ret=$?
      if [ -n "$selected" ]; then
        # the += lets it insert at current pos instead of replacing
        LBUFFER+="${selected}"
      fi
      zle reset-prompt
      return $ret
    }
    zle -N fzf-atuin-history-widget
    bindkey '^R' fzf-atuin-history-widget
  }

  atuin-setup
fi
