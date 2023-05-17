resource "aws_instance" "webapp-test" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = var.instype
  availability_zone      = var.ZONE1
  key_name               = var.keyname
  vpc_security_group_ids = ["sg-0608ede8d0d252e7b"]
  tags = {
    Name    = "webapp-test"
    Project = "webapp"
  }
}

