#!/bin/bash

vagrant_plugin_install() {
	plugins=$(vagrant plugin list | grep $1)
	if [[ -z $plugins ]]; then
		vagrant plugin install $1
	else
		vagrant plugin update $1
	fi
}

echo "Configure Vagrant"
vagrant_plugin_install vagrant-vbguest

echo "Build box"
vagrant destroy --force
vagrant up --provider=virtualbox --install-provider --destroy-on-error

echo "Package box"
rm -rf ps.box
vagrant package --output ps.box
