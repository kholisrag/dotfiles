# shellcheck disable=2148,SC2168,SC1090

# Defer switcher (kubeswitch) initialization to speed up shell startup
(( $+commands[switcher] )) || return 0

_switcher-setup() {
  # Remove this hook after first run
  add-zsh-hook -d precmd _switcher-setup

  # Initialize switcher
  source <(switcher init zsh)

  # Command completion
  source <(switch completion zsh)

  # Use alias `s` instead of `switch`
  alias s=switch
}

# Initialize lazily on first prompt
autoload -Uz add-zsh-hook
add-zsh-hook precmd _switcher-setup
