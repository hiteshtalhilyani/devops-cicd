# Automated steps to setup EKS cluster using vagrant
1. Go vagrant file path
2. Run vagrant up - it will setup required tools using script "eks-tools-setup.sh"
        - awscli
        - eksctl
        - kubectl 
3. Login to vagrant vm 
        vagrant ssh 

4. setup aws configure using iam user cli credentials
5. Go /vagrant path change required variables in the script if required  "eks-cluster-setup.sh" script
6. eksctl delete cluster <cluster_name>