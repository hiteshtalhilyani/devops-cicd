provider "aws" {
  #access_key = ""
  #secret_key = ""   
  region = "ap-south-1"
}

resource "aws_instance" "first-tfec2" {
  ami                    = "ami-022d03f649d12a49d"
  instance_type          = "t2.micro"
  availability_zone      = "ap-south-1a"
  key_name               = "hkt-devkey"
  vpc_security_group_ids = ["sg-0608ede8d0d252e7b"]
  tags = {
    Name    = "Test-Instance"
    Project = "webapp"
  }
}