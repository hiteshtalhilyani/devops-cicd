resource "aws_vpc" "hktvpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "hkttfvpc"
  }
}

resource "aws_subnet" "hkt-sub-pub-1" {
  vpc_id                  = aws_vpc.hktvpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.ZONE1
  map_public_ip_on_launch = "true"

  tags = {
    Name = "hkttfvpc-pubsub-1"
  }
}

resource "aws_subnet" "hkt-sub-pub-2" {
  vpc_id                  = aws_vpc.hktvpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.ZONE2
  map_public_ip_on_launch = "true"

  tags = {
    Name = "hkttfvpc-pubsub-2"
  }
}

resource "aws_subnet" "hkt-sub-pub-3" {
  vpc_id                  = aws_vpc.hktvpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = var.ZONE3
  map_public_ip_on_launch = "true"

  tags = {
    Name = "hkttfvpc-pubsub-3"
  }
}



resource "aws_subnet" "hkt-sub-pri-1" {
  vpc_id                  = aws_vpc.hktvpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = var.ZONE1
  map_public_ip_on_launch = "true"

  tags = {
    Name = "hkttfvpc-prisub-1"
  }
}


resource "aws_subnet" "hkt-sub-pri-2" {
  vpc_id                  = aws_vpc.hktvpc.id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = var.ZONE2
  map_public_ip_on_launch = "true"

  tags = {
    Name = "hkttfvpc-prisub-2"
  }
}

resource "aws_subnet" "hkt-sub-pri-3" {
  vpc_id                  = aws_vpc.hktvpc.id
  cidr_block              = "10.0.6.0/24"
  availability_zone       = var.ZONE3
  map_public_ip_on_launch = "true"

  tags = {
    Name = "hkttfvpc-prisub-3"
  }
}

resource "aws_internet_gateway" "hktvpc-igw" {
  vpc_id = aws_vpc.hktvpc.id

  tags = {
    Name = "hktvpc-igw"
  }
}

resource "aws_route_table" "hktvpc-pub-RT" {
  vpc_id = aws_vpc.hktvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hktvpc-igw.id
  }

  tags = {
    Name = "hktvpc-pub-RT"
  }
}

resource "aws_route_table_association" "pub1-rt-a" {
  subnet_id      = aws_subnet.hkt-sub-pub-1.id
  route_table_id = aws_route_table.hktvpc-pub-RT.id
}

resource "aws_route_table_association" "pub2-rt-a" {
  subnet_id      = aws_subnet.hkt-sub-pub-2.id
  route_table_id = aws_route_table.hktvpc-pub-RT.id
}

resource "aws_route_table_association" "pub3-rt-a" {
  subnet_id      = aws_subnet.hkt-sub-pub-3.id
  route_table_id = aws_route_table.hktvpc-pub-RT.id
}
