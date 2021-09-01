# Deployment Through Virtualisation
This project demonstrates how effecting portable building and deployment of software applications is accomplished through virtualisation.
The application to be deployed is a simple PHP web application that allows users to add pizzas to a database. It also has an admin interface that 
allows admins to add and delete pizzas from the database. 

This project does not focus in the functionality of the application. It focuses on how it is built, e.g., its deployment relies on virtualisation. 

The application operates through the coordination of three different
Virtual machines. The first is responsible for data storage, the second runs a web interface for users, and the third provides
administrative functionality.

# **Build Instructions**

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
