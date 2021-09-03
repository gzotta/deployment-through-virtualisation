# Deployment Through Virtualisation
This project demonstrates how effecting portable building and deployment of software applications is accomplished through virtualisation.
The application to be deployed is a simple PHP web application that allows users to add pizzas to a database. It also has an admin interface that 
allows admins to add and delete pizzas from the database. 

This project does not focus in the functionality of the application. It focuses on how it is built, e.g., its deployment relies on virtualisation. 

The application operates through the coordination of three different
Virtual machines. The first is responsible for data storage, the second runs a web interface for users, and the third provides
administrative functionality.


## **Build Instructions**

- **Prerequistes:** VirtualBox, Vagrant.
- Clone repository, then open a shell at the location of the repository and run the `vagrant up` command to start VMs.
- After Vagrant has finished booting and provisioning the VMs, open in web-browser:

To open the user portal:
http://127.0.0.1:8080
or
http://localhost:8080

To open the admin portal:
http://127.0.0.1:8081
or
http://localhost:8081 





## **Two different types of change that a developer might make to the code of my repository, and how they can subsequently rebuild and rerun the application after they have made such changes.**

-	Change of working environment: in the Vagrant file you can modify config.vm.box = "ubuntu/xenial64"  to a different box that matches your use case. 
-	Change of VM’s provisioning: if a developer needs to change the configuration of a VM to match a particular specification, it can be done through the shell script of the specific VM in the Vagrant file.  
After cloning my repository, and modifying the Vagrant file, open a shell in the current directory and run the vagrant up command to rebuild and rerun the application. If you had vagrant up before, make sure to run vagrant destroy command before running the vagrant up command again. 




## **Acknowledgement**
I did not know how to program in PHP so I give credit to https://github.com/iamshaunjp and his PHP tutorial https://github.com/iamshaunjp/php-mysql-tutorial thanks to this tutorial I learnt very useful skills for programming in PHP, also my pizza PHP app is based on this tutorial.


