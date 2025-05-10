#!/bin/sh

# Check if chezmoi is in PATH first, otherwise use the one in HOME/bin
if command -v chezmoi &> /dev/null; then
  chezmoi_bin_path="$(command -v chezmoi)"
else
  chezmoi_bin_path="${HOME}/bin/chezmoi"
  # Make sure the binary exists
  if [ ! -x "$chezmoi_bin_path" ]; then
    echo "Error: chezmoi not found in PATH or at ${chezmoi_bin_path}"
    exit 1
  fi
fi

# We cannot use chezmoi templating engine
# ref: https://www.chezmoi.io/user-guide/advanced/install-your-password-manager-on-init/
export CHEZMOI_DEST_DIR="${HOME}"
export CHEZMOI_SOURCE_DIR="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
# echo "CHEZMOI_DEST_DIR: $CHEZMOI_DEST_DIR"
# echo "CHEZMOI_SOURCE_DIR: $CHEZMOI_SOURCE_DIR"

##- USE WITH YOUR OWN RISK
# check if `CZ_AGE_KEY` is set for non-interactive decryption automation
# Known Use Cases:
# - Use in Github Codespaces
if [ -n "$CZ_AGE_KEY" ]; then
  mkdir -p "$CHEZMOI_DEST_DIR/.config/chezmoi"
  echo "$CZ_AGE_KEY" > "$CHEZMOI_DEST_DIR/.config/chezmoi/key.txt"
  chmod 600 "$CHEZMOI_DEST_DIR/.config/chezmoi/key.txt"
# else
#   echo "CZ_AGE_KEY is not set, skipping non-interactive decryption."
fi

# check if `CHEZMOI_SOURCE_DIR/key.txt.age` exists
# If not we need to decrypt the key.txt.age file with interactive prompt passphrase
if [ ! -f "$CHEZMOI_DEST_DIR/.config/chezmoi/key.txt" ]; then
  echo "Decrypt using key.txt.age file..."
  mkdir -p "$CHEZMOI_DEST_DIR/.config/chezmoi"
  $chezmoi_bin_path age decrypt --output "$CHEZMOI_DEST_DIR/.config/chezmoi/key.txt" --passphrase "$CHEZMOI_SOURCE_DIR/key.txt.age"
  chmod 600 "$CHEZMOI_DEST_DIR/.config/chezmoi/key.txt"
# else
#   echo "$CHEZMOI_DEST_DIR/.config/chezmoi/key.txt already exists, skipping decryption."
fi
