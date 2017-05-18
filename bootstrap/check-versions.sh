#!/bin/bash

. /vagrant/resources/colors.sh

# This script needs admin rights
if [ 0 != $(id -u) ]; then
	echox "${text_red}Error:${text_reset} This script must be run as root!"
	exit 1
fi

BOX=$(cat /etc/box_version)
DEBIAN=$(cat /etc/debian_version)
VBOXGUESTADDITIONS=$(echo `modinfo vboxguest` | sed 's/.*\bversion: \([^ ]*\).*/\1/')
PUPPET=$(puppet --version)
POSTGRESQL=$(echo `psql -V` | sed 's/psql (PostgreSQL) \(.*\)/\1/')
REDIS=$(echo `redis-server -v` | sed 's/Redis server v=\([^ ]*\).*/\1/')
MAILCATCHER=$(echo `gem list | grep mailcatcher` | sed -r 's/mailcatcher \((.*)\)/\1/')
APACHE2=$(echo `apache2ctl -v 2>&1` | sed 's/.*Apache\/\([^ ]*\).*/\1/')
PHP=$(echo `php -v` | sed 's/PHP \([^-]*\).*/\1/')
PHPFPM=$(echo `php-fpm7.0 -v` | sed 's/PHP \([^-]*\).*/\1/')
XDEBUG=$(echo `php -v` | sed 's/.*Xdebug v\([^,]*\).*/\1/')
COMPOSER=$(echo `composer 2>&1` | sed 's/.*Composer version \([^ ]*\).*/\1/')
NODEJS=$(echo `node -v` | sed 's/v\([^,]*\).*/\1/')
NPM=$(npm -v)
YARN=$(npm --version)

echo 'Box: '$NEAPBOX
echo '`-- Debian: '$DEBIAN
echo '  +-- VirtualBox Guest Additions: '$VBOXGUESTADDITIONS
echo '  +-- Puppet: '$PUPPET
echo '  +-- PostgreSQL: '$POSTGRESQL
echo '  +-- Redis: '$REDIS
echo '  +-- MailCatcher: '$MAILCATCHER
echo '  +-- Apache 2: '$APACHE2
echo '  +-- PHP: '$PHP
echo '  | +-- PHP-FPM: '$PHPFPM
echo '  | +-- Xdebug: '$XDEBUG
echo '  | `-- Composer: '$COMPOSER
echo '  +-- NodeJS: '$NODEJS
echo '  | `-- NPM: '$NPM
echo '  `-- Yarn: '$YARN
