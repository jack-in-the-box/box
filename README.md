# Box

A Vagrant box for web development.

## Read me first

This project aims to give you the necessary tools to build yourself the Box.  
**Note:** If you only intend to use the Box, you will never have to build it yourself! Instead, get it from:
* [GitHub releases](https://github.com/jack-in-the-box/box/releases)
* [Atlas by HashiCorp](https://atlas.hashicorp.com/jitb/boxes/box)

## About

**Version:** 1.6.0  
**Project Owner:** [Jack in the Box](https://github.com/jack-in-the-box)

## Prerequisites

In order to build the Box effectively, you'll need to have a few tools installed:

1. Install [Git](https://git-scm.com)
2. Install [VirtualBox](http://virtualbox.org)
3. Install [Vagrant](http://vagrantup.com)

### Windows-specific ###

1. Add the Git binaries to your path

### Recommended

1. Use a development workstation with at least 2 cores and 8GB of RAM, as Vagrant should be allocated 1GB of RAM
2. Install [Vagrant::VBGuest](https://github.com/dotless-de/vagrant-vbguest), to manage the host's VirtualBox Guest Additions on the guest system  
`vagrant plugin install vagrant-vbguest`

## Build ##

1. `git clone https://github.com/jack-in-the-box/box.git` to clone the latest version
2. Change into the directory `box`
3. Run `vagrant up`
4. Run `vagrant package --output ps.box`

**Note**: Steps 3. and 4. can be replaced with a call to `build.sh` on bash available environments.

## What you get ##

After the build process is done, you have a file named `ps.box` that can be imported in Vagrant or VirtualBox.
To import the built box in Vagrant, use `vagrant box add metadata.json`

### Software stack ###

This box uses Vagrant's [shell provisioner](https://docs.vagrantup.com/v2/provisioning/shell.html) over a large collection of scripts to kick things off.

Once Vagrant is done provisioning the VM, you will have a box containing:
* [Debian](https://www.debian.org/) Jessie 8.8, as operating system, with:
    * [VirtualBox](https://www.virtualbox.org/) Guest Additions 5.1.22
* [PostgreSQL](http://www.postgresql.org/) 9.5.7, as database system
* [Redis](http://redis.io/) 2.8.19, as data structure store
* [MailCatcher](https://mailcatcher.me/) 0.6.5 as mail catching server
* [Apache 2](https://httpd.apache.org/) 1.11.10, as web server, with:
* [PHP](http://php.net/) 7.0.19, as server-side scripting language, with:
    * [PHP-FPM](http://php-fpm.org/) 7.0.19, as PHP process manager
    * [Xdebug](http://xdebug.org/) 2.5.1, as debugger and profiler tool
    * [Composer](https://getcomposer.org/) 1.4.2, as dependency manager
* [NodeJS](https://nodejs.org/) 6.10.3, as JavaScript runtime
    * [NPM](https://www.npmjs.com/) 4.6.1, as JavaScript package Manager
* [Yarn](https://yarnpkg.com/) 0.24.5, as dependy manager
