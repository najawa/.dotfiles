#!/usr/bin/env bash
#
# Google Chrome installer for Ubuntu
#

set -euo pipefail

echo "==> Installing Google Chrome..."

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "${TEMP_DIR}"' EXIT

sudo apt-get install -y libxss1 libappindicator1 libindicator7 || true

wget -O "${TEMP_DIR}/google-chrome.deb" \
  https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i "${TEMP_DIR}/google-chrome.deb" || sudo apt-get install -fy

echo "==> Google Chrome installation complete!"
