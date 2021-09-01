# -*- mode: ruby -*-
# vi: set ft=ruby :

# A Vagrantfile to set up three VMs, two webservers and a database server,
# connected together using an internal network with manually-assigned
# IP addresses for the VMs.

Vagrant.configure("2") do |config|
  # Use Ubuntu 20.04  for all VMs.
  config.vm.box = "ubuntu/xenial64"
  config.vm.boot_timeout = 1200

  # 1st VM: webserver_user.
  config.vm.define "webserver_user" do |webserver_user|
    # These are options specific to the webserver_user VM
    webserver_user.vm.hostname = "webserver-user"
    
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
    webserver_user.vm.network "private_network", ip: "192.168.2.11"

    # This following line is only necessary in the CS Labs.
    webserver_user.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]

   # Use virtualbox as hypervisor
   webserver_user.vm.provider "virtualbox" do |vb|
     # This line to setup the name of our virtual machine as it will appear in virtual box.
     vb.name = "webserver_user"
     # Don't display the VirtualBox GUI when booting the machine
     vb.gui = false
     # 1GB RAM
     vb.memory = "1024"
   end


    # Now we have a section specifying the shell commands to provision
    # the webserver_user VM. Note that the file user.conf is copied
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
      a2ensite user
      # ... and disable the default website provided with Apache
      a2dissite 000-default
      # Reload the webserver configuration, to pick up our changes
      service apache2 reload
    SHELL
  end

  # 2nd VM: database server.
  config.vm.define "dbserver" do |dbserver|
  dbserver.vm.hostname = "dbserver"
  # Note that the IP address is different from that of the webserver_user
  # above: it is important that no two VMs attempt to use the same
  # IP address on the private_network.
  dbserver.vm.network "private_network", ip: "192.168.2.12"
  # This following line is only necessary in the CS Labs.
  dbserver.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]

  # Use virtualbox as hypervisor
  dbserver.vm.provider "virtualbox" do |vb|
    # This line to setup the name of our virtual machine as it will appear in virtual box.
    vb.name = "dbserver"
    # Don't display the VirtualBox GUI when booting the machine
    vb.gui = false
    # 1GB RAM
    vb.memory = "1024"
  end
  
  # Now we have a section specifying the shell commands to provision
  # the dbserver VM. 
  dbserver.vm.provision "shell", inline: <<-SHELL
    echo "database server has started"
    # Update Ubuntu software packages.
    apt-get update
      
    # We create a shell variable MYSQL_PWD that contains the MySQL root password
    export MYSQL_PWD='insecure_mysqlroot_pw'

    # If you run the `apt-get install mysql-server` command
    # manually, it will prompt you to enter a MySQL root
    # password. The next two lines set up answers to the questions
    # the package installer would otherwise ask ahead of it asking,
    # so our automated provisioning script does not get stopped by
    # the software package management system attempting to ask the
    # user for configuration information.
    echo "mysql-server mysql-server/root_password password $MYSQL_PWD" | debconf-set-selections 
    echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD" | debconf-set-selections

    # Install the MySQL database server.
    apt-get -y install mysql-server

    # Run some setup commands to get the database ready to use.
    # First create a database.
    echo "CREATE DATABASE bytes_pizza;" | mysql

    # Then create a database user "webuser" with the given password.
    echo "CREATE USER 'webuser'@'%' IDENTIFIED BY 'insecure_db_pw';" | mysql

    # Grant all permissions to the database user "webuser" regarding
    # the "pizza" database that we just created, above.
    echo "GRANT ALL PRIVILEGES ON bytes_pizza.* TO 'webuser'@'%'" | mysql
    
    # Set the MYSQL_PWD shell variable that the mysql command will
    # try to use as the database password ...
    export MYSQL_PWD='insecure_db_pw'

    # ... and run all of the SQL within the setup-database.sql file,
    # which is part of the repository containing this Vagrantfile, so you
    # can look at the file on your host. The mysql command specifies both
    # the user to connect as (webuser) and the database to use (pizza).
    cat /vagrant/setup-database.sql | mysql -u webuser bytes_pizza

    # By default, MySQL only listens for local network requests,
    # i.e., that originate from within the dbserver VM. We need to
    # change this so that the webserver_user VM can connect to the
    # database on the dbserver VM. Use of `sed` is pretty obscure,
    # but the net effect of the command is to find the line
    # containing "bind-address" within the given `mysqld.cnf`
    # configuration file and then to change "127.0.0.1" (meaning
    # local only) to "0.0.0.0" (meaning accept connections from any
    # network interface).
    sed -i'' -e '/bind-address/s/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

    # We then restart the MySQL server to ensure that it picks up
    # our configuration changes.
    service mysql restart
  SHELL
 end

  # 3rd VM: webserver_admin.
  config.vm.define "webserver_admin" do |webserver_admin|
    # These are options specific to the webserver_admin VM
    webserver_admin.vm.hostname = "webserver-admin"
    
    # This type of port forwarding means that our host computer can
    # connect to IP address 127.0.0.1 port 8081, and that network
    # request will reach our webserver_admin VM's port 80.
    webserver_admin.vm.network "forwarded_port", guest: 80, host: 8081, host_ip: "127.0.0.1"
    
    # We set up a private network that our VMs will use to communicate
    # with each other. Note that I have manually specified an IP
    # address for our webserver_admin VM to have on this internal network,
    # too. There are restrictions on what IP addresses will work, but
    # a form such as 192.168.2.x for x being 11, 12 and 13 (three VMs)
    # is likely to work.
    webserver_admin.vm.network "private_network", ip: "192.168.2.13"

    # This following line is only necessary in the CS Labs.
    webserver_admin.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant", mount_options: ["dmode=775,fmode=777"]

   # Use virtualbox as hypervisor
   webserver_admin.vm.provider "virtualbox" do |vb|
     # This line to setup the name of our virtual machine as it will appear in virtual box.
     vb.name = "webserver_admin"
     # Don't display the VirtualBox GUI when booting the machine
     vb.gui = false
     # 1GB RAM
     vb.memory = "1024"
   end


    # Now we have a section specifying the shell commands to provision
    # the webserver_admin VM. Note that the file admin.conf is copied
    # from this host to the VM through the shared folder mounted in
    # the VM at /vagrant
    webserver_admin.vm.provision "shell", inline: <<-SHELL
    echo "admin webserver has started"
    # Install the Apache Web Server (version 2). Here I used the   
    # apt package management system because I'm working on a Linux system
    # such as Debian or Ubuntu.
      apt-get update
      apt-get install -y apache2 php libapache2-mod-php php-mysql
            
      # Change VM's webserver_admin's configuration to use shared folder.
      # (Look inside test-website.conf for specifics.)
      cp /vagrant/admin.conf /etc/apache2/sites-available/
      # activate our website configuration ...
      a2ensite admin
      # ... and disable the default website provided with Apache
      a2dissite 000-default
      # Reload the webserver configuration, to pick up our changes
      service apache2 reload
    SHELL
  end
end

#  LocalWords:  webserver xenial64

    