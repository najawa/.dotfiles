#!/usr/bin/env bash
#
# Zsh and Oh-My-Zsh installer
#

set -euo pipefail

echo "==> Installing Zsh and Oh-My-Zsh..."

if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git "${HOME}/.oh-my-zsh" || \
    git clone git@github.com:ohmyzsh/ohmyzsh.git "${HOME}/.oh-my-zsh"
fi

# Change default shell to zsh
if command -v zsh &>/dev/null; then
  sudo chsh -s "$(command -v zsh)" "${USER}"
  echo "==> Default shell changed to zsh"
else
  echo "Warning: zsh not found in PATH"
fi

echo "==> Zsh installation complete!"
