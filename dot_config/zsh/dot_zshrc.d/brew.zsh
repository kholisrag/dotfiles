# Homebrew setup - static configuration to avoid slow eval
(( $+commands[brew] )) || return 1

# Use static paths on Apple Silicon Macs instead of eval $(brew shellenv)
if [[ -d /opt/homebrew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
  export HOMEBREW_REPOSITORY="/opt/homebrew"

  # Add Homebrew's zsh completions to fpath
  fpath=("/opt/homebrew/share/zsh/site-functions" $fpath)

  # Use path_helper to properly set PATH
  eval "$(/usr/bin/env PATH_HELPER_ROOT="/opt/homebrew" /usr/libexec/path_helper -s)"

  # Set MANPATH if not empty
  [[ -z "${MANPATH-}" ]] || export MANPATH=":${MANPATH#:}"

  # Set INFOPATH
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

elif [[ -d /usr/local/Homebrew ]]; then
  export HOMEBREW_PREFIX="/usr/local"
  export HOMEBREW_CELLAR="/usr/local/Cellar"
  export HOMEBREW_REPOSITORY="/usr/local/Homebrew"

  # Add Homebrew's zsh completions to fpath
  fpath=("/usr/local/share/zsh/site-functions" $fpath)

  # Use path_helper
  eval "$(/usr/libexec/path_helper -s)"

  # Set MANPATH if not empty
  [[ -z "${MANPATH-}" ]] || export MANPATH=":${MANPATH#:}"

  # Set INFOPATH
  export INFOPATH="/usr/local/share/info:${INFOPATH:-}"
fi

