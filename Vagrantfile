# -*- mode: ruby -*-
# vi: set ft=ruby :

# A Vagrantfile to set up three VMs, a webserver, a database server, and a 
# batch querying server.

# Sets vagrant version.
Vagrant.configure("2") do |config|
  
  # Sets the box to use.
  config.vm.box = "ubuntu/xenial64"

  # Sets up webserver VM.
  config.vm.define "webserver" do |webserver|
    webserver.vm.hostname = "webserver"

    # Set up port forwarding for the host connection, so the host can connect via localhost.
    webserver.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

    # Set up a private network for communication between VM's.
    webserver.vm.network "private_network", ip: "192.168.2.11"

    # Sets up the vagrant shared folder.
    webserver.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]

    # Provisisions the VM on startup.
    webserver.vm.provision "shell", path: "build-webserver.sh"
  end

  # Sets up database server VM.
  config.vm.define "dbserver" do |dbserver|
    dbserver.vm.hostname = "dbserver"

    # Add VM to the private network
    dbserver.vm.network "private_network", ip: "192.168.2.12"

    # Sets up the vagrant shared folder.
    dbserver.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]

    # Provisisions the VM on startup.
    dbserver.vm.provision "shell", path: "build-dbserver.sh"
  end

  # Sets up batching querying server
  config.vm.define "batchserver" do |batchserver|
    batchserver.vm.hostname = "batchserver"

    # Add VM to the private network
    batchserver.vm.network "private_network", ip: "192.168.2.13"

    # Sets up the vagrant shared folder.
    batchserver.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]

    # Provisisions the VM on startup.
    batchserver.vm.provision "shell", path: "build-batchserver.sh"
  end

end
