
resource "aws_instance" "bastion-host" {
  ami                    = lookup(var.AMIS, var.REGION)
  instance_type          = var.instype
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.webappkey.key_name
  subnet_id              = module.vpc.public_subnets[0]
  count                  = var.instance_count
  vpc_security_group_ids = [aws_security_group.webapp-bastion-sg.id]

  tags = {
    Name    = "webapp-bastion"
    Project = "webapp"
  }
  provisioner "file" {
    content     = templatefile("templates/db-deploy.tmpl", { rds-endpoint = aws_db_instance.webapp-rds.address, dbuser = var.dbuser, dbpass = var.dbpass })
    destination = "/tmp/webapp-dbdeploy.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/webapp-dbdeploy.sh",
      "sudo sh /tmp/webapp-dbdeploy.sh"
    ]
  }
  connection {
    user        = var.USERNAME
    private_key = file(var.pri_key)
    host        = self.public_ip
  }
  depends_on = [aws_db_instance.webapp-rds]
}
