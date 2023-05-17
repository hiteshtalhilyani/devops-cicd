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

variable "vpc_name" {
  default = "webapp-vpc"
}

variable "vpc_cidr" {
  default = "172.21.0.0/16"
}

variable "pub1_cidr" {
  default = "172.21.1.0/24"
}

variable "pub2_cidr" {
  default = "172.21.2.0/24"
}

variable "pub3_cidr" {
  default = "172.21.3.0/24"
}

variable "priv1_cidr" {
  default = "172.21.4.0/24"
}

variable "priv2_cidr" {
  default = "172.21.5.0/24"
}

variable "priv3_cidr" {
  default = "172.21.6.0/24"
}


variable "AMIS" {
  type = map(any)
  default = {
    ap-south-1        = "ami-022d03f649d12a49d" ## EC2 Linux AMI
    me-central-1      = "ami-05940876d6cc68263"
    ap-south-1_ubuntu = "ami-03a933af70fa97ad2" # ubuntu AMI
  }
}
variable "USERNAME" {
  type        = string
  default     = "ubuntu"
  description = "User Name to connect "
}

variable "instype" {
  type    = string
  default = "t2.micro"
}

variable "pri_key" {
  default = "webappkey"

}
variable "pub_key" {
  default = "webappkey.pub"
}

variable "MYIP" {
  default     = "92.97.21.163/32"
  description = "MY IP to allow Access from SG "
}

variable "rmquser" {
  default = "rabbit"
}
variable "rmqpass" {
  default = "QwerZxcv#$98765"
}

variable "dbname" {
  default = "accounts"
}
variable "dbuser" {
  default = "admin"
}

variable "dbpass" {
  default = "admin123"
}

variable "instance_count" {
  default = "1"
}

