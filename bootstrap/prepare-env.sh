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

	echo "Create sources files"

	echo "- Empty default source list"
	echo "" > /etc/apt/sources.list

	echo "- security.list"
	echo "deb     http://security.debian.org/ stable/updates main contrib" >/etc/apt/sources.list.d/security.list
	echo "deb-src http://security.debian.org/ stable/updates main contrib" >>/etc/apt/sources.list.d/security.list

	echo "- stretch.list"
	echo "deb     http://httpredir.debian.org/debian/ stretch main contrib" >/etc/apt/sources.list.d/stretch.list
	echo "deb-src http://httpredir.debian.org/debian/ stretch main contrib" >>/etc/apt/sources.list.d/stretch.list

	echo "- jessie.list"
	echo "deb     http://httpredir.debian.org/debian/ jessie main contrib" >/etc/apt/sources.list.d/jessie.list
	echo "deb-src http://httpredir.debian.org/debian/ jessie main contrib" >>/etc/apt/sources.list.d/jessie.list

	echo "Set stretch as default repository"
	echo 'APT::Default-Release "stretch";' >/etc/apt/apt.conf.d/99default-release

	echo "Clean local packages list"
	apt-get clean
	sudo rm -rf /var/lib/apt/lists/*

	echo "Update packages to the latest version"
	export DEBIAN_FRONTEND=noninteractive
	apt-get -y -q update
	apt-get -y --force-yes -q -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
	apt-get -y --force-yes -q dist-upgrade
	apt-get -y -q autoremove --purge

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
)
catch || {
	case $ex_code in
		*)
			echox "${text_red}Error:${text_reset} An unexpected exception was thrown"
			throw $ex_code
		;;
	esac
}
