# -*- mode: ruby -*-
# vi: set ft=ruby :

# A Vagrantfile to set up three VMs, two webservers and a database server,
# connected together using an internal network with manually-assigned
# IP addresses for the VMs.

Vagrant.configure("2") do |config|
  # Use Ubuntu 20.04  for all VMs.
  config.vm.box = "ubuntu/xenial64"

  # 1st webserver VM:
  config.vm.define "webserver_user" do |webserver_user|
    # These are options specific to the webserver_user VM
    webserver_user.vm.hostname = "webserver_user"
    
    # This type of port forwarding means that our host computer can
    # connect to IP address 127.0.0.1 port 8080, and that network
    # request will reach our webserver_user VM's port 80.
    webserver_user.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    
    # We set up a private network that our VMs will use to communicate
    # with each other. Note that I have manually specified an IP
    # address for our webserver_user VM to have on this internal network,
    # too. There are restrictions on what IP addresses will work, but
    # a form such as 192.168.2.x for x being 11, 12 and 13 (three VMs)
    # is likely to work.
    webserver.vm.network "private_network", ip: "192.168.2.11"

    # This following line is only necessary in the CS Labs.
    webserver.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]

   # Use virtualbox as hypervisor
   webserver_user.vm.provider "virtualbox" do |vb|
     # This line to setup the name of our virtual machine as it will appear in virtual box.
     vb.name = "webserver_user"
     # don't display the VirtualBox GUI when booting the machine
     vb.gui = false
     # 1GB RAM
     vb.memory = "1024"


    # Now we have a section specifying the shell commands to provision
    # the webserver_user VM. Note that the file test-website.conf is copied
    # from this host to the VM through the shared folder mounted in
    # the VM at /vagrant
    webserver_user.vm.provision "shell", inline: <<-SHELL
    echo "user webserver has started"
    # Install the Apache Web Server (version 2). Here I used the   
    # apt package management system because I'm working on a Linux system
    # such as Debian or Ubuntu.
      apt-get update
      apt-get install -y apache2 php libapache2-mod-php php-mysql
            
      # Change VM's webserver_user's configuration to use shared folder.
      # (Look inside test-website.conf for specifics.)
      cp /vagrant/user.conf /etc/apache2/sites-available/
      # activate our website configuration ...
      a2ensite test-website
      # ... and disable the default website provided with Apache
      a2dissite 000-default
      # Reload the webserver configuration, to pick up our changes
      service apache2 reload
    SHELL
  end

  

end

#  LocalWords:  webserver xenial64
