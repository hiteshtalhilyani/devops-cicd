# About The Project

1. Multitier Java Based Web Application 
2. Setup on Laptop or Desktop for beginners
3. Help to setup the environment locally on laptop
4. Application Flow & Setp 
        a) Clone the source code
        b) Spin up VMs on any HyperVisor, we will be using Oracle Virtual Machine
        c) Validate and Set up the services 
            i)      MySQL
            ii)     Memcached
            iii)    Rabbit MQ
            iv)     Tomcat 
            v)      Nginx 
            vi)     App Build & Deploy
            vii)    Access the Application via Browser


# Software Prerequisites
#
- JDK 1.8 or later
- Maven 3 or later
- MySQL 5.6 or later

# Technologies 
- Spring MVC
- Spring Security
- Spring Data JPA
- Maven
- JSP
- MySQL

# Database
Used Mysql DB for the application
MSQL DB Installation Steps for Linux ubuntu 14.04:
- $ sudo apt-get update
- $ sudo apt-get install mysql-server

Then look for the file :
- /src/main/resources/accountsdb
- accountsdb.sql file is a mysql dump file.we have to import this dump to mysql db server
- > mysql -u <user_name> -p accounts < accountsdb.sql

# Steps to Setup the Project From Scratch
1. Machine Provisioning using vagrant
- Vagrant plugins
a. vagrant plugin install vagrant-hostmanager
b. vagrant plugin install vagrant-vbguest   # Optional need to execute in case of vboxsf error

# Final Review - Flow of Execution 
        1. Setup Tools like - vagrant, oracle virtual, chocolatey for windows etc
        2. clone source code from GIT
        3. cd to vagrant dir - follow the path of Vagrantfile
        4. Bring up the VMs  
        5. Validate the Host Entry and Reachability of VMs
        6. Setup All Services in respective VMs.  
                        Services
                        1. Nginx:
                        Web Service
                        2. Tomcat
                        Application Server
                        3. RabbitMQ
                        Broker/Queuing Agent
                        4. Memcache
                        DB Caching
                        5. MySQL
                        SQL Database 
                        6. App Build & Deploy using mvn
                        7. ElasticSearch
                        Indexing/Search service

        7. Verify the Application 
                http://192.168.56.11/login    # Replace IP with webserver IP - web01
                userid : 
                passwd : 
                 
