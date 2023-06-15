
VM SETUP

1. Go to vagrant Folder
    - cd Automated Setup - Multi Tier WebApp Locally
    - cd vagrant
    - vagrant up 
    - vboxsf
2.  vagrant ssh web01
    ping app01
    logout

3. vagrant ssh app01
    cat /etc/hosts
    ping mc01
    ping rmq01
    ping db01 


Setup should be done in below mentioned order
1. MySQL (Database SVC)
2. Memcache (DB Caching SVC)
3. RabbitMQ (Broker/Queue SVC)
4. Tomcat (Application SVC )

1. Login to MYSQL Server from same vagrant path 
    vagrant ssh db01
    sudo su -
    yum update all
    - Set Database_Password
    DATABASE_PASSWORD="MySQL123"
    echo $DATABASE_PASSWORD
    vi /etc/profile  for permanent variable 
    DATABASE_PASSWORD='MySQL123'
    source /etc/profile 
    echo $DATABASE_PASSWORD
    yum install epel-release -y
    yum install git mariadb-server -y
    systemctl start mariadb
    systemctl enable mariadb
    mysql_secure_installation

    mysql -u root -p"$DATABASE_PASSWORD" -e "create database accounts"
    mysql -u root -p"$DATABASE_PASSWORD" -e "grant all privileges on accounts.* TO 'admin'@'app01' identified by 'MySQL123'"

    cd /root/<project_name>
    mysql -u root -pMySQL123 accounts < src/main/resources/db_backup.sql
    mysql -u root -p"$DATABASE_PASSWORD" -e "FLUSH PRIVILEGES"
    mysql -u root -p"$DATABASE_PASSWORD"
    show databases;
    use accounts;
    show tables;

2. Setup Memcache , login to memcache server
    vagrant ssh mc01
    yum update all 
    yum install epel-release -y
    yum install memcached
    systemctl start memcached
    systemctl enable memcached
    systemctl status memcached
    memcached -p 11211 -U 11111 -u memcached -d
    ss -tunlp |grep -i 11211
    systemctl status memcached
    ps -ef |grep - 11211

3. Set up RabbitMQ , login to Rabbit MQ Server

    yum update all
    wget http://packages.erlang-solutions.com/erlang-solutions-2.0-1.noarch.rpm
    rpm -Uvh erlang-solutions-2.0-1.noarch.rpm
    yum -y install erlang socat
    curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
    yum install rabbitmq-server -y
    systemctl start rabbitmq-server
    systemctl enable rabbitmq-server
    systemctl status rabbitmq-server
    sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'
    rabbitmqctl add_user test test
    rabbitmqctl set_user_tags test administrator
    systemctl restart rabbitmq-server
    systemctl status rabbitmq-server


4. Set up Application on app01 Server, Login to server app01

        yum update -y
        yum install epel-release -y
        yum install java-1.8.0-openjdk -y
        yum install git maven wget -y
        wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.37/bin/apache-tomcat-8.5.37.tar.g
        tar xzvf apache-tomcat-8.5.37.tar.gz
        useradd --home-dir /usr/local/tomcat8 --shell /sbin/nologin tomcat
        pwd
        cp -r /root/apache-tomcat-8.5.37/* /usr/local/tomcat8/
        chown -R tomcat.tomcat /usr/local/tomcat8
        vi /etc/systemd/system/tomcat.service
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
        cat /etc/systemd/system/tomcat.service                               
        systemctl daemon-reload
        systemctl start tomcat
        systemctl status tomcat
        systemctl enable tomcat
        systemctl status tomcat
        ps -ef |grep -i tomcat


5. # CODE BUILD & DEPLOY - Application Deployment 

    git clone -b local-setup https://github.com/devopshydclub/vprofile-project.git
    /root/vprofile-project/src/main/resources/application.properties
    - Change DB password if different
    cd /root/vprofile-project
    mvn install 
    /root/vprofile-project/target/vprofile-v2.war   # Artifact 
    ls /usr/local/tomcat8/webapps/ROOT/
    rm -rf /usr/local/tomcat8/webapps/ROOT/
    cd /root/vprofile-project/target
    cp vprofile-v2.war /usr/local/tomcat8/webapps/ROOT.war
    ls -lrt /usr/local/tomcat8/webapps   #After extraction it will create ROOT directory 
    chown tomcat.tomcat /usr/local/tomcat8/webapps -R
    systemctl restart tomcat
    exit 

6. NGINX Setup on Web01 , Login to server web01 
    cat /etc/os-release
    apt upgrade
    apt install nginx -y
        # Create Nginx conf file with below content
            vi /etc/nginx/sites-available/vproapp
            upstream vproapp {
                    server app01:8080;
            }
            server {
                    listen 80;
            location / {
                    proxy_pass http://vproapp;
                    }
            }
    ls -lrt /etc/nginx/sites-enabled/default
    rm -rf /etc/nginx/sites-enabled/default
    ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp
    systemctl restart nginx

 






    

