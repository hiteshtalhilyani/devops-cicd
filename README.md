# ansible-vpc
To create AWS VPC using ansible
1. Create Ubuntu EC2 instance
2. Install Ansible 
    - apt install python3-boto3 python3-botocore python3-boto -y 
3. Assign administrator role on ec2 instance
4. Verify 
    - aws sts get-caller-identity
5. Created test-playbook.yml to create ec2-keypair


