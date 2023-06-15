                   PROJECT SETUP ON VAGRANT

Prerequisite

1.	Oracle VM Virtualbox
2.	Vagrant
3.	Vagrant plugins
a.	vagrant plugin install vagrant-hostmanager
b.	vagrant plugin install vagrant-vbguest

4.	Git bash or equivalent editor


VM SETUP

1.	Clone source code.
2.	Cd into the repository.
3.	Switch to the local-setup branch.
4.	cd into vagrant/Manual_provisioning.

Bring up vm’s
$ vagrant up

NOTE: Bringing up all the vm’s may take a long time based on various factors. If vm setup stops in the middle run “vagrant up” command again.

INFO: All the vm’s hostname and /etc/hosts file entries will be automatically updated.
 
PROVISIONING
Services
1.	Nginx:
 Web Service

2.	Tomcat
 
Application Server
 
3.	RabbitMQ
Broker/Queuing Agent
4.	Memcache
DB Caching
5.	ElasticSearch
Indexing/Search service
6.	MySQL
SQL Database

Setup should be done in below mentioned order
1.	MySQL (Database SVC)
2.	Memcache (DB Caching SVC)
3.	RabbitMQ (Broker/Queue SVC)
4.	Tomcat	(Application SVC)
5.	Nginx	(Web SVC)

 
# MYSQL Setup

Login to the db vm
$ vagrant ssh db01

Verify Hosts entry, if entries missing update the it with IP and hostnames
# cat /etc/hosts

# vi /etc/profile 
DATABASE_PASS='admin123'
source /etc/profile

Update OS with latest patches
# yum update -y

Set Repository
# yum install epel-release -y

Install Maria DB Package
# yum install git mariadb-server -y

Starting & enabling mariadb-server
# systemctl start mariadb
# systemctl enable mariadb

RUN mysql secure installation script.
# mysql_secure_installation
NOTE: Set db root password, I will be using  “admin123” as password

Set root password? [Y/n] Y New password:
Re-enter new password:
Password updated successfully! Reloading privilege tables..
... Success!

By default, a MariaDB installation has an anonymous user, allowing anyone to log into MariaDB without having to have a user account created for
them. This is intended only for testing, and to make the installation go a bit smoother. You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n] Y
... Success!

Normally, root should only be allowed to connect from 'localhost'. This ensures that someone cannot guess at the root password from the network.
 
Disallow root login remotely? [Y/n] n
... skipping.

By default, MariaDB comes with a database named 'test' that anyone can access. This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n] Y
-	Dropping test database...
... Success!
-	Removing privileges on test database...
... Success!

Reloading the privilege tables will ensure that all changes made so far will take effect immediately.

Reload privilege tables now? [Y/n] Y
... Success!

# mysql -u root -p
exit 

Set DB name and users.
# mysql -u root -p"$DATABASE_PASS" -e  "create database accounts"
# mysql -u root -p"$DATABASE_PASS" -e "grant all privileges on accounts.* TO 'admin'@'app01' identified by 'admin123' "

OR 

mysql> grant all privileges on accounts.* TO 'admin'@’%’ identified by 'MySQL123' ; mysql> FLUSH PRIVILEGES;
mysql> exit;

Download Source code & Initialize Database.
# git clone https://github.com/hiteshtalhilyani/Java-WebApp-Local-Setup.git
# cd Java-WebApp-Local-Setup\project-info\src\main\resources
cd /root/Java-WebApp-Local-Setup/project-info/src/main/resources
cp db_backup.sql /root
cd /root
1.  mysql -u root -p"$DATABASE_PASS" accounts < db_backup.sql   
2.  mysql -u root -p"$DATABASE_PASS" -e "FLUSH PRIVILEGES"
3.  mysql -u root - padmin123 
4.  show databases;  
5.  use accounts;
6.  show tables;    # mysql> show tables;


Restart mariadb-server
# systemctl restart mariadb

-> Required Only if Firewall is configured on  Laptop 

Starting the firewall and allowing the mariadb to access from port no. 3306
# systemctl start firewalld
# systemctl enable firewalld
# firewall-cmd --get-active-zones
# firewall-cmd --zone=public --add-port=3306/tcp --permanent # firewall-cmd --reload
# systemctl restart mariadb
 

# MEMCACHE SETUP   - Install, start & enable memcache on port 11211
1. vagrant ssh mc01
2. sudo su -
3. yum install epel-release -y
4. yum install memcached -y
5. systemctl start memcached
6. systemctl enable memcached
7. systemctl status memcached
8. memcached -p 11211 -U 11111 -u memcached -d
9. ss -tunlp |grep -i 11211

 
# RABBITMQ SETUP

Login to the RabbitMQ vm
1. vagrant ssh rmq01
2. cat /etc/hosts
3. yum update -y
4. yum install epel-release -y
5. wget http://packages.erlang-solutions.com/erlang-solutions-2.0-1.noarch.rpm
6. rpm -Uvh erlang-solutions-2.0-1.noarch.rpm
7. yum -y install erlang socat
8. curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
9. yum install rabbitmq-server -y 
9. systemctl start rabbitmq-server
10. systemctl enable rabbitmq-server
11. systemctl status rabbitmq-server
12. echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config  # config change
13. rabbitmqctl add_user test test
14. rabbitmqctl set_user_tags test administrator
15. systemctl restart rabbitmq-server

 
# TOMCAT SETUP
1. vagrant ssh app01
2. sudo su - 
3. cat /etc/hosts
4. yum update -y
5. yum install epel-release -y
6. yum install java-1.8.0-openjdk -y
7. yum install git maven wget -y
8. cd /root
9. wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.37/bin/apache-tomcat-8.5.37.tar.gz
10. tar xzvf apache-tomcat-8.5.37.tar.gz
11. cd apache-tomcat-8.5.37
12. useradd --home-dir /usr/local/tomcat8 --shell /sbin/nologin tomcat
13. cp -r  /root/apache-tomcat-8.5.37/* /usr/local/tomcat8/
14. chown -R tomcat.tomcat /usr/local/tomcat8
15. vi /etc/systemd/system/tomcat.service

[Unit] 
Description=Tomcat 
After=network.target

[Service] 
User=tomcat
WorkingDirectory=/usr/local/tomcat8
Environment=JRE_HOME=/usr/lib/jvm/jre
Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_HOME=/usr/local/tomcat8
Environment=CATALINE_BASE=/usr/local/tomcat8
ExecStart=/usr/local/tomcat8/bin/catalina.sh run
ExecStop=/usr/local/tomcat8/bin/shutdown.sh
SyslogIdentifier=tomcat-%i

[Install]
WantedBy=multi-user.target

16. systemctl daemon-reload
17. systemctl start tomcat
18. systemctl enable tomcat
19. systemctl status tomcat
 
# CODE BUILD & DEPLOY (app01)

Download Source code
20. git clone https://github.com/hiteshtalhilyani/Java-WebApp-Local-Setup.git
21. cd /root/Java-WebApp-Local-Setup/project-info/src/main/resources
22. vim application.properties
    - make required changes and build repository
23. Update file with backend server details
    -  vim /root/Java-WebApp-Local-Setup/project-info/src/main/resources/application.properties
24. cd Java-WebApp-Local-Setup\project-info
25. mvn install
26. systemctl stop tomcat # sleep 120
27. rm -rf /usr/local/tomcat8/webapps/ROOT*
28. cp target/webapp-v2.war /usr/local/tomcat8/webapps/ROOT.war 
29. systemctl start tomcat
30. sleep 300
31. chown tomcat.tomcat usr/local/tomcat8/webapps -R # systemctl restart tomcat
 
# NGINX SETUP
Login to the Nginx vm
1. vagrant ssh web01
2. cat /etc/hosts
3. apt update # apt upgrade
4. apt install nginx -y
5. vi /etc/nginx/sites-available/vproapp

Create Nginx conf file with below content
# 
upstream vproapp
{
 server app01:8080;
}
        server {
        listen 80;
        location / {
        proxy_pass http://vproapp;
        }
}
Remove default nginx conf
6.  rm -rf /etc/nginx/sites-enabled/default

Create link to activate website
7. ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp

Restart Nginx
8. systemctl restart nginx 


# Validate 
http://192.168.56.11/login 
adminvp

