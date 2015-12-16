# -*- mode: ruby -*-
# vi: set ft=ruby :
# 
Vagrant.configure(2) do |config|

    config.ssh.insert_key = false
    config.vbguest.auto_update = false
    config.vbguest.no_remote = true

    config.vm.define "box" do |box|

        # VM hostname
        box.vm.hostname = "box.jack.tools"

        # The VM will be built off Ubuntu 14.04 LTS 64 bit
        box.vm.box = "jitb/debian/jessie64"
        box.vm.box_url = "https://github.com/jack-in-the-box/box/releases/download/0.1/jitb-debian-jessie64.box"

        # Create a private network, which allows host-only access to the machine
        # using a specific IP.
        box.vm.network :private_network, ip: "192.168.01.01"
    end

end
