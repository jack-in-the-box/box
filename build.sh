#!/bin/sh

vagrant plugin install vagrant-vbguest

vagrant up --provision
vagrant vbguest
vagrant package --output ps.box
