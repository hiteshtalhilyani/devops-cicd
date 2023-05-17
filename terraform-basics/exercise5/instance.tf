resource "aws_key_pair" "test-key" {
  key_name   = "tftestkey"
  public_key = file("tftestkey.pub")
}

resource "aws_instance" "testec2" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = var.instype
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.test-key.key_name
  vpc_security_group_ids = ["sg-0608ede8d0d252e7b"]
  tags = {
    Name    = "testec2"
    Project = "webapp"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]

  }
  connection {
    user        = var.USER
    private_key = file("tftestkey")
    host        = self.public_ip
  }
}

output "public_ip" {
  value = aws_instance.testec2.public_ip
}

output "private_ip" {
  value = aws_instance.testec2.private_ip
}