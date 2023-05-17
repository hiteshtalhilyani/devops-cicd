resource "aws_security_group" "hkt_tf_sg" {
  name        = "hkt_tf_sg"
  description = "Allow  inbound traffic"
  vpc_id      = aws_vpc.hktvpc.id

  ingress {
    description = "SG to allow port SSH from MYIP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MYIP]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}


