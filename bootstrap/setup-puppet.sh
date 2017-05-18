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

	echo "Add repository to Aptitude"
	cd /tmp
	wget https://apt.puppetlabs.com/puppetlabs-release-jessie.deb
	dpkg -i puppetlabs-release-jessie.deb
	apt-get -y -q update

	echo "Install Puppet package"
	apt-get -y -q install puppet

	echo "Install modules"
	puppet module install puppetlabs-postgresql
	puppet module install puppetlabs-inifile
	puppet module install puppetlabs-apache
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}

