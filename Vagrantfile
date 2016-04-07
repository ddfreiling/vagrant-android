# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"
  
  # Fix ubuntu/vagrant output annoyance
  config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end
  
  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui
  config.vm.provider "virtualbox" do |v|
    v.name = "trusty64_android"
    v.gui = true
    v.memory = 2048
    v.cpus = 1
  end
  
  config.vm.provider "vmware_fusion" do |v, override|
    override.vm.box_url = "http://files.vagrantup.com/trusty64_vmware.box"
    v.name = "trusty64_android"
    v.gui = true
    v.vmx["memsize"] = "2048"
    v.vmx["numvcpus"] = "1"
  end
  
  config.vm.define "trusty64_android" do |trusty64_android|
  end
  
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 5037, host: 5037, auto_correct: true # Android ADB port
  

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.  
  
  # Install xfce and virtualbox additions
  # config.vm.provision "shell", inline: "sudo apt-get update"
  # config.vm.provision "shell", inline: "sudo apt-get install -y xfce4 virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11"
  # Permit anyone to start the GUI
  # config.vm.provision "shell", inline: "sudo sed -i 's/allowed_users=.*$/allowed_users=anybody/' /etc/X11/Xwrapper.config"
  
  config.vm.provision :chef_solo do |chef|

    chef.cookbooks_path = "cookbooks"

    chef.add_recipe "apt"
    chef.add_recipe "git"
    chef.add_recipe "build-essential" 
    chef.add_recipe "java" 
    chef.add_recipe "sqlite-dev"
    chef.add_recipe "vim"

  end

  config.vm.provision "shell", inline: "echo Installing build tools, Android SDK and NDK..."
  config.vm.provision "shell", path: "provision.sh"
  config.vm.provision "shell", inline: "echo Installation complete"
  
  config.vm.synced_folder "./", "/vagrant", owner: 'vagrant', group: 'vagrant', nfs: true
end
