# Jack in the Box development Box

A Vagrant box for web development.

## Read me first

This project aims to give you the necessary tools to build yourself the Box.  
If you only intend to use the Box, you will never have to build it yourself! Instead, get it from our public releases.

### Public releases

You can directly add the box to your environment using the public versions available on [Atlas by HashiCorp](https://atlas.hashicorp.com/jitb/boxes/box).  
To do so, run `vagrant box add jitb/box`.

You can also download the packaged box file through the [GitHub releases](https://github.com/jack-in-the-box/box/releases).

## About

**Version:** 2.0.0  
**Project Owner:** [Jack in the Box](https://github.com/jack-in-the-box)

## Prerequisites

In order to build the Box effectively, you'll need to have a few tools installed:

1. Install [Git](https://git-scm.com)
2. Install [VirtualBox](http://virtualbox.org)
3. Install [Vagrant](http://vagrantup.com)

### Recommended

1. Use a development workstation with at least 2 cores and 8GB of RAM, as Vagrant should be allocated 1GB of RAM
2. Install [Vagrant::VBGuest](https://github.com/dotless-de/vagrant-vbguest), to manage the host's VirtualBox Guest Additions on the guest system  
`vagrant plugin install vagrant-vbguest`

## Build ##

1. `git clone https://github.com/jack-in-the-box/box.git` to clone the latest version
2. Change into the directory `box`
3. Run `vagrant up`
4. Run `vagrant package --output ps.box`

**Note**: Steps 3. and 4. can be replaced with a call to `build.sh` script on bash available environments.

## What you get ##

After the build process is done, you have a file named `ps.box` that can be imported in Vagrant or VirtualBox.
To import the built box in Vagrant, run `vagrant box add metadata.json`.

### Software stack ###

This box uses Vagrant's [shell provisioner](https://docs.vagrantup.com/v2/provisioning/shell.html) over a large collection of scripts to kick things off.

Once Vagrant is done provisioning the VM, you will have a box containing:
* [Debian](https://www.debian.org/) Stretch 9.0, as operating system, with:
    * [VirtualBox](https://www.virtualbox.org/) Guest Additions 5.1.22
* [Puppet](https://puppet.com/) Puppet 3.7.2, as configuration manager
* [PostgreSQL](http://www.postgresql.org/) 9.5.7, as database system
* [Redis](http://redis.io/) 2.8.19, as data structure store
* [MailCatcher](https://mailcatcher.me/) 0.6.5 as mail catching server
* [Apache 2](https://httpd.apache.org/) 2.4.25, as web server, with:
* [PHP](http://php.net/) 7.0.19, as server-side scripting language, with:
    * [PHP-FPM](http://php-fpm.org/) 7.0.19, as PHP process manager
    * [Xdebug](http://xdebug.org/) 2.5.0, as debugger and profiler tool
    * [Composer](https://getcomposer.org/) 1.4.2, as dependency manager
    * [Adminer](https://www.adminer.org/) 4.3.1, as web database manager
* [NodeJS](https://nodejs.org/) 6.11.0, as JavaScript runtime
    * [NPM](https://www.npmjs.com/) 5.0.4, as JavaScript package Manager
* [Yarn](https://yarnpkg.com/) 0.24.5, as dependy manager
* [ImageMagick](https://www.imagemagick.org/) 6.8.9, as images converter
