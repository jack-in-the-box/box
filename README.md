# Jack in the box Vagrant dev boxes

- jitb-debian-jessie64 is a box based on Debian Jessie 64 with Puppet, Apache2, PHP5.6 and Postgresql9.4

Warning: Security is inexistant! Don't use it in production!

## How-to
To rebuild this box:
- Init a new vagrant project with a debian-jessy64.
- Manage users and passwords
- Install all dependencies (Puppet, Apache2, PHP5.6 and Postgresql9.4, ...)
- Check public/private key.
- Force config.ssh.insert_key config key to false in your vagrant file.
- Package the box

That's all!

## Root password

The root password is "vagrant".
The user "vagrant" is in the sudoers.

## SSH keys
This box use the default unsecure keys, due to a bug in vagrant > 1.7.2.
- https://github.com/mitchellh/vagrant/tree/master/keys

## Source box
- https://atlas.hashicorp.com/debian/boxes/jessie64

## Official documentation
- https://docs.vagrantup.com/v2/virtualbox/boxes.html

## Tutorials
- https://scotch.io/tutorials/how-to-create-a-vagrant-base-box-from-an-existing-one
- https://blog.engineyard.com/2014/building-a-vagrant-box

## Known bugs (vagrant > 1.7.2)
When generating this box, a vagrant bug cause SSH connection failures. Do not forget to force config.ssh.insert_key config key to false

See more at: 
- https://github.com/mitchellh/vagrant/issues/5186
