sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php8.3 php8.3-cli php8.3-common php8.3-mbstring php8.3-xml php8.3-zip php8.3-curl php8.3-bcmath php8.3-gd php8.3-intl php8.3-mysql php8.3-pgsql php8.3-sqlite3 php8.3-soap php8.3-readline php8.3-opcache
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
composer global require laravel/installer
