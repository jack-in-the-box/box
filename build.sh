#!/bin/sh

vagrant up --provision
vagrant package --output ps.box
