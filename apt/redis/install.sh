#!/usr/bin/env bash
#
# Redis installer (from source)
#

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

echo "==> Installing Redis from source..."

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "${TEMP_DIR}"' EXIT

cd "${TEMP_DIR}"
curl -O http://download.redis.io/redis-stable.tar.gz
tar xzvf redis-stable.tar.gz
cd redis-stable
make
sudo make install

# Configure Redis
sudo mkdir -p /etc/redis
sed 's/^supervised.*/supervised systemd/' redis.conf | \
  sed 's|^dir.*|dir /var/lib/redis|' | \
  sudo tee /etc/redis/redis.conf >/dev/null

sudo cp "${SCRIPT_DIR}/redis.service" /etc/systemd/system/redis.service

# Create redis user and directories
sudo adduser --system --group --no-create-home redis || true
sudo mkdir -p /var/lib/redis
sudo chown redis:redis /var/lib/redis
sudo chmod 770 /var/lib/redis

# Start and enable Redis
sudo systemctl daemon-reload
sudo systemctl start redis
sudo systemctl enable redis

echo "==> Redis installation complete!"
