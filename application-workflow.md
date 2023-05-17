<h1>Application-WorkFlow</h1>

1. Create Account in AWS
2. Login to AWS Account
3. Create Key Pairs to login for Elastic Beanstalk 
4. Create Security Groups for elastic cache, RDS, ActiveMQ
5. Create following 
        - RDS
        - AWS Elastic Cache
        - AWS ActiveMQ
6. Create Elastic BeanStalk Environment
7. Update backend Securiy Group to allow traffic from Beanstalk SG
8. Allow SG of backend to allow internal Traffic
9. Launch EC2-Instance for DB Initialization
10. Login to the Instance and Initialize DB
11. Change healthcheck on beanstalk to /login 
12. Add 443 Listner to ELB
13. Build Artifact with Backend Information
14. Deploy Artifact to Beanstalk
15. Create CDN with ssl cert
16. Update entry in Hostinger or Godaddy DNS Zones or you can also use public hosted AWS Route53
17. Test the URL 



