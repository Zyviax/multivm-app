# -*- mode: ruby -*-
# vi: set ft=ruby :

# A Vagrantfile to set up three VMs, a webserver, a database server, and a 
# batch querying server.

# Sets vagrant version.
Vagrant.configure("2") do |config|

  # Sets up database server VM.
  config.vm.define "dbserver" do |dbserver|
    dbserver.vm.hostname = "dbserver"
    
    # Sets the box to use.
    dbserver.vm.box = "ubuntu/xenial64"
    
    # Add VM to the private network
    dbserver.vm.network "private_network", ip: "192.168.2.12"
    
    # Sets up the vagrant shared folder.
    dbserver.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]
    
    # Provisisions the VM on startup.
    dbserver.vm.provision "shell", path: "build-dbserver.sh"
  end
  
  # Sets up pdf server
  config.vm.define "pdfserver" do |pdfserver|
    pdfserver.vm.hostname = "pdfserver"
    
    # Sets the box to use.
    pdfserver.vm.box = "ubuntu/trusty64"
    
    # Add VM to the private network
    pdfserver.vm.network "private_network", ip: "192.168.2.13"
    
    # Sets up the vagrant shared folder.
    pdfserver.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]
    
    # Provisisions the VM on startup.
    pdfserver.vm.provision "shell", path: "build-pdfserver.sh"
  end
  
  # Sets up webserver VM.
  config.vm.define "webserver" do |webserver|
    webserver.vm.hostname = "webserver"

    # Sets the box to use.
    webserver.vm.box = "ubuntu/xenial64"

    # Set up port forwarding for the host connection, so the host can connect via localhost.
    webserver.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

    # Set up a private network for communication between VM's.
    webserver.vm.network "private_network", ip: "192.168.2.11"

    # Sets up the vagrant shared folder.
    webserver.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]

    # Provisisions the VM on startup.
    webserver.vm.provision "shell", path: "build-webserver.sh"
    webserver.vm.provision "shell", path: "build-webserver-2.sh", privileged: false

    # Trigger to delete unimportant files.
    webserver.trigger.before :destroy do |trigger|
      trigger.run_remote = {inline: "rm /vagrant/conv/conversions.xls; rm /vagrant/conv/conversions.pdf; rm /vagrant/www/conversions.pdf"}
      trigger.on_error = :continue
    end

  end

end
