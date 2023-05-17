resource "aws_db_subnet_group" "webapp-rds-subgrp" {
  name       = "main"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "Subnet Group for RDS"
  }
}

resource "aws_elasticache_subnet_group" "webapp-cache-subgrp" {
  name       = "webapp-cache-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "Elastic Cache Subgroup"
  }
}

resource "aws_db_instance" "webapp-rds" {
  allocated_storage      = 10
  db_name                = var.dbname
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  username               = var.dbuser
  password               = var.dbpass
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  storage_type           = "gp2"
  publicly_accessible    = "false"
  multi_az               = "false"
  db_subnet_group_name   = aws_db_subnet_group.webapp-rds-subgrp.name
  vpc_security_group_ids = [aws_security_group.webapp-backend-sg.id]

}

resource "aws_elasticache_cluster" "webapp-cache" {
  cluster_id           = "webapp-cache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = "11211"
  security_group_ids   = [aws_security_group.webapp-backend-sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.webapp-cache-subgrp.name
}

resource "aws_mq_broker" "webapp-mq" {
  broker_name        = "webapp-mq"
  engine_type        = "ActiveMQ"
  engine_version     = "5.15.9"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.webapp-backend-sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]
  user {
    username = var.rmquser
    password = var.rmqpass
  }
}

    