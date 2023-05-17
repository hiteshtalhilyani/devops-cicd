variable "REGION" {
  default = "ap-south-1"
}

variable "ZONE1" {
  type        = string
  default     = "ap-south-1a"
  description = "Zone define to create EC2 instance"
}

variable "AMIS" {
  type = map(any)
  default = {
    ap-south-1   = "ami-022d03f649d12a49d"
    me-central-1 = "ami-05940876d6cc68263"
  }
}
variable "instype" {
  type    = string
  default = "t2.micro"
}
variable "keyname" {
  default = "hkt-devkey"
}