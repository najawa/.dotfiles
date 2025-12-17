#!/usr/bin/env bash
#
# thefuck CLI installer
#

set -euo pipefail

echo "==> Installing thefuck..."

sudo apt-get update
sudo apt-get install -y python3-dev python3-pip python3-venv

# Install using pipx for better isolation (if available) or pip
if command -v pipx &>/dev/null; then
  pipx install thefuck
else
  pip3 install --user thefuck
fi

echo "==> thefuck installation complete!"
echo "    Add 'eval \$(thefuck --alias)' to your shell config"
