#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

# This script needs admin rights
if [ 0 != $(id -u) ]; then
	echox "${text_red}Error:${text_reset} This script must be run as root!"
	exit 1
fi

try
(
	throwErrors

	echo "Copy Composer executable"
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php composer-setup.php --install-dir=/usr/local/bin --filename=composer
	php -r "unlink('composer-setup.php');"
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
