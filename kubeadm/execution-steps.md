# Steps to execute vagrant file 

1. Requirements 
    - choco
    - oracle virtualization 
    - vagrant 

2. kubeadm setup using vagrant automation & scripts
    - It will create 3 kubecluster nodes (1 master and 2 worker nodes)
    - we will be using docker engine
    - need to update versions variables in the scripts for docker-ce & docker-cli 
    - os - ubuntu 
    - cd <devops-projects> # path
    - vagrant up 
    - vagrant ssh kubemaster
    - kubectl get no

3. Create test deployment 