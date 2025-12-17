#!/usr/bin/env bash
#
# PostgreSQL installer for Ubuntu
#

set -euo pipefail

echo "==> Installing PostgreSQL..."

# Add PostgreSQL GPG key (modern approach, not deprecated apt-key)
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  sudo gpg --dearmor -o /etc/apt/keyrings/postgresql.gpg
sudo chmod a+r /etc/apt/keyrings/postgresql.gpg

# Add repository
CODENAME=$(lsb_release -cs)
echo "deb [signed-by=/etc/apt/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt/ ${CODENAME}-pgdg main" | \
  sudo tee /etc/apt/sources.list.d/pgdg.list >/dev/null

sudo apt-get update
sudo apt-get install -y --no-install-recommends postgresql libpq-dev

# Start PostgreSQL
sudo service postgresql start

# Create user role
CURRENT_USER=$(whoami)
sudo -u postgres psql -c "CREATE ROLE ${CURRENT_USER} WITH SUPERUSER LOGIN" || \
  echo "Role ${CURRENT_USER} may already exist"

echo "==> PostgreSQL installation complete!"
