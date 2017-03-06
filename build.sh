#!/bin/sh

vagrant plugin install vagrant-vbguest

vagrant up --provision
vagrant vbguest

rm ps.box
vagrant package --output ps.box
