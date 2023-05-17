variable "REGION" {
  default = "ap-south-1"
}

variable "ZONE1" {
  type        = string
  default     = "ap-south-1a"
  description = "Zone define to create EC2 instance"
}

variable "ZONE2" {
  type        = string
  default     = "ap-south-1b"
  description = "Zone define to create EC2 instance"
}

variable "ZONE3" {
  type        = string
  default     = "ap-south-1c"
  description = "Zone define to create EC2 instance"
}

variable "AMIS" {
  type = map(any)
  default = {
    ap-south-1   = "ami-022d03f649d12a49d"
    me-central-1 = "ami-05940876d6cc68263"
  }
}
variable "USER" {
  type        = string
  default     = "ec2-user"
  description = "User Name to connect "
}

variable "instype" {
  type    = string
  default = "t2.micro"
}


variable "MYIP" {
  default     = "92.97.21.163/32"
  description = "MY IP to allow Access from SG "
}