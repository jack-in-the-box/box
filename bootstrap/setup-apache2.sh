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

	echo "Install packages"
	apt-get -y -q install -t testing apache2 apache2-bin apache2-data apache2-utils

	echo "Enable modules"
	a2enmod access_compat alias auth_basic authn_core authn_file authz_core authz_host authz_user deflate dir \
		expires filter http2 mime mpm_event negotiation proxy proxy_fcgi proxy_wstunnel rewrite setenvif \
		socache_shmcb ssl status
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}

