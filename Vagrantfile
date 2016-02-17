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

        # The VM will be built off the latest box
        box.vm.box = "jitb/box"

        # Synced folder configuration
        box.vm.synced_folder ".", "/vagrant"

        # Create a private network, which allows host-only access to the machine
        # using a specific IP.
        box.vm.network :private_network, ip: "192.168.42.100"
    end

end
