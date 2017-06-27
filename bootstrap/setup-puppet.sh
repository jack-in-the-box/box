#!/bin/bash

. /vagrant/resources/colors.sh
. /vagrant/resources/trycatch.sh

# This script needs admin rights
if [ 0 != $(id -u) ]; then
	echox "${text_red}Error:${text_reset} This script must be run as root!"
	exit 1
fi

PUPPET_VERSION=3.7.2-4

try
(
	throwErrors

	echo "Install Puppet package"
	apt-get -y -q install --install-suggests --allow-downgrades puppet=$PUPPET_VERSION puppet-common=$PUPPET_VERSION
	# Mark Puppet packages not to be upgraded with a more recent version
	sudo apt-mark hold puppet-common puppet

	# echo "Install modules"
	puppet module install puppetlabs-inifile
	puppet module install puppetlabs-postgresql --version 4.8.0
	puppet module install puppetlabs-apache --version 1.10.0
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}

