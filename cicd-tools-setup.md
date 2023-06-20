#Jenkins Installion on Ubuntu OS

1. create t2.small instance with ubuntu OS
2. Create Security Group and allow access to port 22 & 8080 
3. Add userdata script : userdata.sh
4. login to ec2 instance with "ubuntu" user 
5. view script : curl http://169.254.169.254/latest/user-data
6. Access Jenkins at https:<publicIP>:8080
7. Provide password after login to instance
8. check status :  systemctl status jenkins
9. Jenkins HOME Directory by default : /var/lib/jenkins
10. Select popular plugins : default check mark plugins 
11. create admin password
12. Notedown Jekins URL : http://65.1.106.26:8080/


# Jenkins Setup 
    - create ec2 instance - ubuntu-20.4 (t2.small)
    - Run userdata.sh script 
    - Manage Jenkins -> Global Tool Configuration
        - Add JDK 
            Name: OpenJDK8   #  Remember this name
            Login using ssh : 
                sudo apt update
                sudo  apt install openjdk-8-jdk -y
                java -version   -- it will show jdk-11

        - Set Java Version 
            -   cd /usr/lib/jvm 
            -   Add as HOME in GUI :  /usr/lib/jvm/java-1.8.0-openjdk-amd64

        - Add MAVEN
            - maven3
            - select version - save 

        - Install utility Tools plugins
            - Pipeline Utility Steps
            - Pipeline Maven Integration 
            - Maven Integration 
            - Github Integration 
            - Nexus Artifact Uploader
            - SonarQube Scanner
            - Slack Notification 
            - Build Timestamp 

# Nexus Setup 
    1. Create EC2 instance (Amazonlinux2 - t2.medium -type) using userdata.sh script
    2. Login to nexus instance 
    3. systemctl status nexus 
    4. http://3.110.128.159:8081/
    5. After setting the password create repositories 
    6. Repository :  Create 4 Repositories
        1. maven(hosted) :     webapp-release        # This is to upload the artifacts
        2. maven(proxy):       webapp-maven-central  ## This is to download the dependencies
            Enter URL for central :         https://repo1.maven.org/maven2/
        3. maven(hosted) : webapp-snapshot
            version policy : change from release to snapshot
        4. maven(group ):  webapp-maven-group  
            Group all create repositories ( add them )


# SonarQube Setup 
    1. Create ec2 instance with  ubuntu-20 , type: t2.medium 
    2. Run userdata.sh script
    3. Access via IP : http://13.233.82.185/about   - default user : 
    4. systemctl status sonar
    5. 

# Github Setup 
    1. Create Github Account
    2. Create SSH Key on Laptop 
            ssh-keygen
    3. cd to particular path where keys are generated.
    4. cat .\.ssh\id_rsa.pub
    5. Copy the Key, login to Github, settings "SSH and GPG key", new SSH Key
    6. Give any name to the key and paste the public key 
    7. Test the connectivity : ssh -T git@github.com
            Hi hiteshtalhilyani! You've successfully authenticated, but GitHub does not provide shell access.
    8. Change the URL of your repository 
        git remote set-url origin  https://github.com/hiteshtalhilyani/jenkins-cicd.git
        verify :  cat .git/config
        Exp clone repo:    git clone -b AWS-WebApp-Refactoring  https://github.com/hiteshtalhilyani/AWS-Cloud-WebApp.git

        create branch : git checkout -b ci-jenkins   #will create new branch
                        git checkout main 
                        git push --all origin

    9. Commit from vscode editor
            1. code . # from powershell it will open the vscode
            2. Commit from VS code 
	    3. git config --global user.email "hiteshtalhilyani@outlook.com"
	    4. git config --global user.name "Hitesh Talhilyani"
        5. git config --global user.name 
        6. git config --global user.email 
        7. cat ~/.gitconfig
             






            