module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name            = var.vpc_name
  cidr            = var.vpc_cidr
  azs             = [var.ZONE1, var.ZONE2, var.ZONE3]
  private_subnets = [var.priv1_cidr, var.priv2_cidr, var.priv3_cidr]
  public_subnets  = [var.pub1_cidr, var.pub2_cidr, var.pub3_cidr]

  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = true
  single_nat_gateway   = true


  tags = {
    terraform   = "true"
    Environment = "Dev"

  }
  vpc_tags = {
    Name = var.vpc_name
  }
}
