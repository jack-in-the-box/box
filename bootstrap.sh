#!/bin/bash

# Start stopwatch
export BEGIN=$(date +%s)

# Load dependencies
. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

# This script needs admin rights
echox "${text_cyan}Check admin rights"
if [ 0 != $(id -u) ]; then
	echo_error "This script must be run as root!"
	exit 1
fi
echox "${text_green}OK"

try
(
	throwErrors

	echox "${text_cyan}Prepare Debian environment"
	/vagrant/bootstrap/prepare-env.sh

	echox "${text_cyan}Setup ZSH"
	/vagrant/bootstrap/setup-zsh.sh

	echox "${text_cyan}Setup Puppet Agent"
	/vagrant/bootstrap/setup-puppet.sh

	echox "${text_cyan}Setup PostgreSQL"
	/vagrant/bootstrap/setup-postgresql.sh

	echox "${text_cyan}Build Redis"
	/vagrant/bootstrap/build-redis.sh

	echox "${text_cyan}Build MailCatcher"
	/vagrant/bootstrap/setup-mailcatcher.sh

	echox "${text_cyan}Setup Apache 2"
	/vagrant/bootstrap/setup-apache2.sh

	echox "${text_cyan}Setup PHP 7.0"
	/vagrant/bootstrap/setup-php7.0.sh

	echox "${text_cyan}Setup Composer"
	/vagrant/bootstrap/setup-composer.sh

	echox "${text_cyan}Setup Adminer"
	/vagrant/bootstrap/setup-adminer.sh

	echox "${text_cyan}Setup NPM"
	/vagrant/bootstrap/setup-npm.sh

	echox "${text_cyan}Setup Yarn"
	/vagrant/bootstrap/setup-yarn.sh

	echox "${text_cyan}Setup ImagMagick"
	/vagrant/bootstrap/setup-imagemagick.sh

	echox "${text_cyan}Clean up"
	/vagrant/bootstrap/cleanup.sh

	echox "${text_cyan}Zero disk"
	/vagrant/bootstrap/zerodisk.sh

	echox "${text_cyan}Installed versions:${text_reset}"
	/vagrant/bootstrap/check-versions.sh

	NOW=$(date +%s)
	DIFF=$(($NOW - $BEGIN))
	MINS=$(($DIFF / 60))
	SECS=$(($DIFF % 60))
	echox "${text_cyan}Info:${text_reset} Bootstrap lasted $MINS mins and $SECS secs"
)
catch || {
	case $ex in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex
		;;
	esac
}
