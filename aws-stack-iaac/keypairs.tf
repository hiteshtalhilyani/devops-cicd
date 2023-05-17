resource "aws_key_pair" "webappkey" {
  key_name   = "webappkey"
  public_key = file(var.pub_key)
}