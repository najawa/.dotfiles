#!/usr/bin/env bash
#
# MariaDB installer for Ubuntu
#

set -euo pipefail

echo "==> Installing MariaDB..."

sudo apt-get update -y
sudo apt-get install -y mariadb-server libmariadb-dev

touch "${HOME}/.env"

if ! grep -q "export MYSQL_PASSWORD" "${HOME}/.env"; then
  MYSQL_USERNAME=$(whoami)
  MYSQL_PASSWORD=$(openssl rand -base64 32)

  {
    echo "export MYSQL_USER='${MYSQL_USERNAME}'"
    echo "export MYSQL_PASSWORD='${MYSQL_PASSWORD}'"
  } >> "${HOME}/.env"

  # Secure the .env file
  chmod 600 "${HOME}/.env"

  cat > "${HOME}/.my.cnf" << EOF
[mysql]
password=${MYSQL_PASSWORD}
EOF
  chmod 600 "${HOME}/.my.cnf"

  sudo service mysql start
  sudo mysql -e "CREATE USER '${MYSQL_USERNAME}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}'" || true
  sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USERNAME}'@'localhost';"

  echo "==> MariaDB credentials saved to ~/.env"
fi

sudo systemctl disable mysql

echo "==> MariaDB installation complete!"
