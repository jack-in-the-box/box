Vagrant.configure(2) do |config|
    config.ssh.insert_key = false
    config.vbguest.auto_update = false
    config.vbguest.no_remote = true

    config.vm.define "box" do |box|
        # VM hostname
        box.vm.hostname = "box.jack.tools"

        # The VM will be built off the latest box
        box.vm.box = "jitb/box"

        # Provider-specific configuration
        box.vm.provider :virtualbox do |vb|
            vb.customize [
                'modifyvm', :id,
                '--cpus', "2",
                '--memory', "512",
                '--name', "Proposal Studio Box"
            ]
        end

        # Synced folder configuration
        box.vm.synced_folder ".", "/vagrant"
        
        # Provisioning script made for cleanup and compression
        box.vm.provision :shell, :inline => "/vagrant/resources/cleanup.sh"
        box.vm.provision :shell, :inline => "/vagrant/resources/zerodisk.sh"
    end
end
