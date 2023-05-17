resource "aws_security_group" "webapp-bean-elb-sg" {
  name        = "webapp-bean-elb-sg"
  description = "security group for bean-elb"
  vpc_id      = module.vpc.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "webapp-bastion-sg" {
  name        = "webapp-bastion-sg"
  description = "Bastion SG for webapp"
  vpc_id      = module.vpc.vpc_id
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [var.MYIP]
  }
}

resource "aws_security_group" "webapp-prod-sg" {
  name        = "webapp-prod-sg"
  description = "EC2 private SG for beanstalk instances"
  vpc_id      = module.vpc.vpc_id
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    security_groups = [aws_security_group.webapp-bastion-sg.id]
    cidr_blocks     = [var.MYIP]
  }
}

resource "aws_security_group" "webapp-backend-sg" {
  name        = "webapp-backend-sg"
  description = "EC2 security Group for RDS, Memcache, App, ActiveMQ"
  vpc_id      = module.vpc.vpc_id
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol        = "-1"
    from_port       = 0
    to_port         = 0
    security_groups = [aws_security_group.webapp-prod-sg.id]
  }
  ingress {
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    security_groups = [aws_security_group.webapp-bastion-sg.id]
  }
}

resource "aws_security_group_rule" "sec_grp_allow_itself" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.webapp-backend-sg.id
  source_security_group_id = aws_security_group.webapp-backend-sg.id

}

