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

	echo "Install alternative shutdown script"
	cp /vagrant/resources/shutdown.sh /usr/local/sbin/shutdown
	chmod +x /usr/local/sbin/shutdown

	echo "Empty the default Aptitude config"
	truncate -s 0 /etc/apt/sources.list

	echo "Create a Jessie based 'stable' Aptitude config"
	cat >/etc/apt/sources.list.d/stable.list <<- EOL
	deb http://httpredir.debian.org/debian jessie main
	deb-src http://httpredir.debian.org/debian jessie main

	deb http://httpredir.debian.org/debian jessie-updates main
	deb-src http://httpredir.debian.org/debian jessie-updates main

	deb http://security.debian.org/ jessie/updates main
	deb-src http://security.debian.org/ jessie/updates main
	EOL

	echo "Create a Stretch based 'testing' Aptitude config"
	cat >/etc/apt/sources.list.d/testing.list <<- EOL
	deb http://httpredir.debian.org/debian stretch main
	deb-src http://httpredir.debian.org/debian stretch main

	deb http://httpredir.debian.org/debian stretch-updates main
	deb-src http://httpredir.debian.org/debian stretch-updates main

	deb http://security.debian.org/ stretch/updates main
	deb-src http://security.debian.org/ stretch/updates main
	EOL

	echo "Setup Aptitude to use 'stable' config by default"
	echo 'APT::Default-Release "stable";' >/etc/apt/apt.conf.d/99defaultrelease

	echo "Clean local packages list"
	apt-get clean
	sudo rm -rf /var/lib/apt/lists/*

	echo "Update packages to the latest version"
	export DEBIAN_FRONTEND=noninteractive
	apt-get -y -q update
	apt-get -y -q -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
	apt-get -y -q dist-upgrade
	apt-get -y -q upgrade

	echo "Install prerequisite packages"
	apt-get -y -q install apt-transport-https build-essential cmake curl facter g++ gcc git libcurl4-openssl-dev \
	                      libpcre++-dev libpcre3-dev libreadline-gplv2-dev libsqlite3-dev libssl-dev make ntp \
	                      pkg-config unzip zlib1g-dev

	echo "Tweak SSH daemon"
	echo 'UseDNS no' >>/etc/ssh/sshd_config

	echo "Tweak Grub"
	cat <<EOF >/etc/default/grub
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.
GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2>/dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX="debian-installer=en_US"
EOF
	update-grub

	echo "Copy Box version file"
	cp /vagrant/VERSION /etc/box_version

	echo "Prepare web folders"
	mkdir -p /var/www
	chown -cR vagrant:vagrant /var/www
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
