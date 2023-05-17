
resource "aws_key_pair" "testtf-key" {
  key_name   = "tftestkey"
  public_key = file("tftestkey.pub")
}

resource "aws_instance" "tfwebec2" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = var.instype
  availability_zone      = var.ZONE1
  subnet_id              = aws_subnet.hkt-sub-pub-1.id
  key_name               = aws_key_pair.testtf-key.key_name
  vpc_security_group_ids = [aws_security_group.hkt_tf_sg.id]
  tags = {
    Name    = "tfwebec2"
    Project = "webapp"
  }
}
resource "aws_ebs_volume" "tfwebec2-ebs-vol2" {
  availability_zone = var.ZONE1
  size              = 3

  tags = {
    Name = "extr-tfwebec2-ebs-vol2"
  }
}
resource "aws_volume_attachment" "attach_ebs_vol2" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.tfwebec2-ebs-vol2.id
  instance_id = aws_instance.tfwebec2.id
}


# provisioner "file" {
#   source      = "web.sh"
#   destination = "/tmp/web.sh"
# }

# provisioner "remote-exec" {
#   inline = [
#     "chmod u+x /tmp/web.sh",
#     "sudo /tmp/web.sh"
#   ]
# }
# connection {
#   user        = var.USER
#   private_key = file("tftestkey")
#   host        = self.public_ip
#   }



output "public_ip" {
  value = aws_instance.tfwebec2.public_ip
}

output "private_ip" {
  value = aws_instance.tfwebec2.private_ip
}

