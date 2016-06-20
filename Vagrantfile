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

        # Provider-specific configuration so you can fine-tune various
        # backing providers for Vagrant. These expose provider-specific options.
        box.vm.provider :virtualbox do |vb|
            # Don't boot with headless mode
            # vb.gui = true
            # Use VBoxManage to customize the VM. For example to change memory:
            vb.customize [
                'modifyvm', :id,
                '--cpus', 2,
                '--memory', "512",
                '--name', "Proposal Studio Box"
            ]
        end

        # Synced folder configuration
        box.vm.synced_folder ".", "/vagrant"

        # Create a private network, which allows host-only access to the machine
        # using a specific IP.
        box.vm.network :private_network, ip: "192.168.42.100"
    end

end
