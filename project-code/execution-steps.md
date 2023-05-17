1. Create Security Group for required Instances, Loadbalancer
2. Create key-pair to access Instances
3. Launch DB instance with centos7 and userdata script
4. Login to DB Instance with user "centos" and ppk format key-pair 
5. Check script after login into instance at  "cat /var/lib/cloud/instance/user-data.txt" or curl http://169.254.169.254/latest/user-data
6. verify DB service - systemctl status mariadb 
7. login to DB - mysql -u root -pMySQL123
8.  show databases;
    use accounts;
    show tables;

9. logout 


# Launch EC2 instance with centos for memchache & Rabbitmq 
1. Launch EC2 instance with centos-7 and provide user data script for memcache
2. Launch EC2 instance with centos-7 and provice user data script for rabbitmq
3. login and verify the services after 10min 
4. Login to memcache server - systemctl status memcached
5. Check the userdata script -  curl http://169.254.169.254/latest/user-data
6. Check port - netstat -tunlp |grep -i 11211
7. login to rabbitmq server -  systemctl status rabbitmq-server

# Add Route53 Enteries
1. Create Private Hosted Zone
2. Note down the private IPs and create simple A Records.
    db01	172.31.34.157
    mc01	172.31.38.96
    rmq01	172.31.45.3	 

# Create Tomcat App Server with ubuntu OS 20 version - ubuntu20 
1. Allow port 22 in app(tomcat) security from your source IP 
2. login with "ubuntu" user to app using private key
3. Check User Script -  curl http://169.254.169.254/latest/user-data


# Local Build , Upload Artifacts to S3 and Deploy on Tomcat Server 

1. Install Required Packages on local server. 
    - Install choco using - https://chocolatey.org/docs/installation
       
       choco install jdk8 -y 
       choco install maven -y 
       choco install awscli -y 

       mvn -version                      # Ensure jdk version should not be greater then 1.8
       choco uninstall jdk8 -y           # Else uninstall maven and install required version 
       choco install jdk8 -y 
       choco install maven 


2. Go to Path - project-code/src/main/resources/
    - Modify application.propeties file hostname 
        db01.webapp.in (domain is based on create hosted zone)
        mc01.webapp.in
        rmq01.webapp.in
    
    - Modify the SQL password if different. 
        jdbc.password=MySQL123

3. Change path to - "project-code" where pom.xml file exist and to generate the artifacts.
       
        mvn install 
    - Once build is succesful it will create the directory "target" in the same path
      it will create "*.war" file inside "project-code/target" directory 

4. Configure AWS CLI to upload Artifacts to S3 bucket 
    - Create IAM User
    - Go to  security credentials
    - Create Access Key  
    - Download Access Key 
             aws configure
             provide : access_key
             provide:  security_credentials
             provide:  default-region (ap-south-1)  where instances exist
             output_format: json 
    
    - Verfiy AWS CLI Access
        aws s3 ls
        aws s3 mb s3://webapp-hkt-artifact-storage   (Ensure S3 bucket name should be unique in 
                                                       the world )

        "make_bucket: webapp-hkt-artifact-storage"

        # project-code\target - ensure directory path 
        aws s3 cp vprofile-v2.war s3://webapp-hkt-artifact-storage  # upload artifacts
        aws s3 ls s3://webapp-hkt-artifact-storage                   # verify upload


    - Create Role for EC2 instance to access S3 bucket and to download Artifacts 
        - Go to AWS Console 
        - IAM Roles
        - Create Role
        - Select EC2 and Select Policy "S3 Administrator Access" 
        - Provide Role Name 
        - Assign Role to "App Server", by right click on EC2 ->Security- Modify IAM Role 

    - Login App Server
        - Allow 22 port access on APP Security Group
        - Install AWSCLI : apt  install awscli
        - aws s3 ls s3://webapp-hkt-artifact-storage  # This will list the uploaded artifact file 
        - aws s3 cp s3://webapp-hkt-artifact-storage/vprofile-v2.war /tmp/vprofile-v2.war

    - Stop Tomcat Service 
        -  systemctl status tomcat9.service
        -  systemctl stop  tomcat9.service
        -  cd /var/lib/tomcat9/webapps
        -  rm -rf ROOT
        -  cp -pr /tmp/vprofile-v2.war /var/lib/tomcat9/webapps/ROOT.war
        -  systemctl start tomcat9.service
        -  It will extract the ROOT.war to ROOT directory in the same path 
        -  cat /var/lib/tomcat9/webapps/ROOT/WEB-INF/classes/application.properties
        -  Check Connectivity 
                telnet mc01.webapp.in 11211
                telnet rmq01.webapp.in 5672
                telnet db01.webapp.in 3306

5. Create Load Balancer 

    - Application is up and Running
    - DB is Up and Running
    - Backend Services are up and Running 
    
    - Now we will create the Target Group for Load Balancer 
        - Create Target Group
        - webapp-tg
        - Select port : 8080
        - Override port : 8080
        - healthcheck : /login
        - select : Application Server - include pending as below 
        - Next and Create Target Group 
    
    - Create Application LB 
        - Select Application LB
        - Add all availability zone
        - Select Target Group
        - Add Listener on 8080 and 443 
        - Select LB Security Group 
        - For 443 - Certificate is Required which is upload on Certificate Manager
        - Create Load Balancer
        - Access the Application with LB - DNS Name 
        - Now Add the CNAME Record which will point to AWS Application LB 
        - Go to the domain provider (Godaddy or Hostinger), select your domain name
        - Go to DNS  CNAME Record
                host: webapp 
                value : LB DNS : webapp-prod-lb-1948573730.ap-south-1.elb.amazonaws.com
        - Save and access the website 
                http://webapp.hiteshtalhilyani.tech/login
                

    




