# main.tf

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "${var.project_name}-VPC"
    project = var.project_name
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.preferred_availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.project_name}-public-subnet"
    project = var.project_name
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_1_cidr_block
  availability_zone = var.preferred_availability_zone

  tags = {
    Name    = "${var.project_name}-private-subnet1"
    project = var.project_name
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_2_cidr_block
  availability_zone = var.another_availability_zone

  tags = {
    Name    = "${var.project_name}-private-subnet2"
    project = var.project_name
  }
}

resource "aws_security_group" "http_access" {
  name        = "${var.project_name}-http_access"
  description = "${var.project_name}-http_access"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "${var.project_name}-http_access"
    project = var.project_name
  }
}

resource "aws_security_group" "remote_access" {
  name        = "${var.project_name}-remote_access"
  description = "${var.project_name}-remote_access"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "${var.project_name}-remote_access"
    project = var.project_name
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name    = "${var.project_name}-public-route-table"
    project = var.project_name
  }
}

resource "aws_route_table" "private_subnet_1_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name    = "${var.project_name}-private-subnet1-route-table"
    project = var.project_name
  }
}

resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_subnet_1_route_table.id
}

resource "aws_route_table" "private_subnet_2_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name    = "${var.project_name}-private-subnet2-route-table"
    project = var.project_name
  }
}

resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_subnet_2_route_table.id
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name    = "${var.project_name}-IGW"
    project = var.project_name
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_eip" "nat_eip" {
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name    = "${var.project_name}-NAT-Gateway"
    project = var.project_name
  }
}

resource "aws_instance" "my_instance_public" {
  count                  = 1
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.http_access.id, aws_security_group.remote_access.id]

  tags = {
    Name    = "${var.project_name}-public-ec2"
    project = var.project_name
  }
}

resource "aws_instance" "my_instance_private_1" {
  count         = 1
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet_1.id
  key_name      = var.key_pair_name

  vpc_security_group_ids = [aws_security_group.http_access.id, aws_security_group.remote_access.id]

  tags = {
    Name    = "${var.project_name}-private-ec2-1"
    project = var.project_name
  }
}

resource "aws_instance" "my_instance_private_2" {
  count         = 1
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet_2.id
  key_name      = var.key_pair_name

  vpc_security_group_ids = [aws_security_group.http_access.id, aws_security_group.remote_access.id]

  tags = {
    Name    = "${var.project_name}-private-ec2-2"
    project = var.project_name
  }
}
