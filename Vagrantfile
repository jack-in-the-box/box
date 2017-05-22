Vagrant.configure(2) do |config|
    # Collect data about the host
    case RbConfig::CONFIG["host_os"]
        when /cygwin|mswin|msys|mingw|bccwin|wince|emc|emx|windows/i
            # Windows
            cpus = `wmic cpu get NumberOfLogicalProcessors`.split("\n")[2].to_i
        when /linux|arch/i
            # linux
            cpus = `nproc`.to_i
        when /darwin|mac os/i
            # MacOS
            cpus = `sysctl -n hw.ncpu`.to_i
        else
            # Others...
            cpus = 2
    end

    config.ssh.insert_key = false
    config.vbguest.auto_update = false
    config.vbguest.no_remote = true

    config.vm.define "box" do |box|
        # VM hostname
        box.vm.hostname = "box.jack.tools"

        # The VM will be built off the latest box
        box.vm.box = "debian/contrib-jessie64"
        box.vm.box_version = ">= 8.7.0"

        # Synced folder configuration
        box.vm.synced_folder ".", "/vagrant"

        # VirtualBox provider
        box.vm.provider :virtualbox do |vb|
            # System configuration
            vb.name = "Box"
            vb.cpus = cpus
            vb.memory = "1024"
            vb.customize [
                "modifyvm", :id,
                "--groups", "/Proposal Studio",
            ]
        end

        #  VirtualBox Guest update
        box.vbguest.auto_update = true
        box.vbguest.installer = DebianVbguest
        box.vbguest.no_remote = true

        # Provisioning script
        box.vm.provision "shell" do |s|
            s.inline = "/vagrant/bootstrap.sh | tee /vagrant/bootstrap.log"
            s.keep_color = true
        end
    end
end

class DebianVbguest < VagrantVbguest::Installers::Debian
    def install(opts=nil, &block)
        communicate.sudo("apt-get -y -q purge virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11", opts, &block)
        @vb_uninstalled = true
        super
    end

    def running?(opts=nil, &block)
        return false if @vb_uninstalled
        super
    end
end
