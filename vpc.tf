# Create VPC 
resource "aws_vpc" "samar_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name        = "${var.projectName}-vpc-${var.env}"
    Environment = var.env
  }
}

# Create Internet Gateways and attached to VPC.
resource "aws_internet_gateway" "samar_ig" {
  vpc_id = aws_vpc.samar_vpc.id

  tags = {
    Name        = "${var.projectName}-ig-${var.env}"
    Environment = var.env
  }
}

#Create public subnet-1 
resource "aws_subnet" "samar_pub_sub_1" {
  vpc_id            = aws_vpc.samar_vpc.id
  availability_zone = var.availablity_zone-a
  cidr_block        = var.pub_sub_cidr-1

  tags = {
    Name        = "${var.projectName}-pub-sub1-${var.env}"
    Environment = var.env
  }
}

#Create public subnet-2
resource "aws_subnet" "samar_pub_sub_2" {
  vpc_id            = aws_vpc.samar_vpc.id
  availability_zone = var.availablity_zone-b
  cidr_block        = var.pub_sub_cidr-2

  tags = {
    Name        = "${var.projectName}-pub-sub2-${var.env}"
    Environment = var.env
  }
}

#Create private subnet-1
resource "aws_subnet" "samar_pri_sub_1" {
  vpc_id            = aws_vpc.samar_vpc.id
  availability_zone = var.availablity_zone-a
  cidr_block        = var.pri_sub_cidr-1

  tags = {
    Name        = "${var.projectName}-pri-sub1-${var.env}"
    Environment = var.env
  }
}

#Create private subnet-2
resource "aws_subnet" "samar_pri_sub_2" {
  vpc_id            = aws_vpc.samar_vpc.id
  availability_zone = var.availablity_zone-b
  cidr_block        = var.pri_sub_cidr-2

  tags = {
    Name        = "${var.projectName}-pri-sub2-${var.env}"
    Environment = var.env
  }
}

# Subnet association between a route table and a subnet1
resource "aws_route_table_association" "samar_pri_sub_a" {
  subnet_id      = aws_subnet.samar_pri_sub_1.id
  route_table_id = aws_route_table.samar_private_rt.id
}

# Subnet association between a route table and a subnet2
resource "aws_route_table_association" "samar_pri_sub_b" {
  subnet_id      = aws_subnet.samar_pri_sub_2.id
  route_table_id = aws_route_table.samar_private_rt.id
}

# Subnet association between a route table and a subnet1
resource "aws_route_table_association" "samar_pub_sub_a" {
  subnet_id      = aws_subnet.samar_pub_sub_1.id
  route_table_id = aws_default_route_table.samar_default_rt.id
}

# Subnet association between a route table and a subnet2
resource "aws_route_table_association" "samar_pub_sub_b" {
  subnet_id      = aws_subnet.samar_pub_sub_2.id
  route_table_id = aws_default_route_table.samar_default_rt.id
}

##Creating An Elastic IP for NAT Gateway

resource "aws_eip" "samar_elastic-ip" {
  vpc                       = true
  associate_with_private_ip = var.elastic-private-ip-range

  tags = {
    Name        = "${var.projectName}-elastic-ip-${var.env}"
    Environment = var.env
    Description = "Elastic IP for NAT Gateway"
  }
}


# Create NAT Gateway
resource "aws_nat_gateway" "samar_nat_gateway" {
  allocation_id = aws_eip.samar_elastic-ip.id
  subnet_id     = aws_subnet.samar_pub_sub_1.id

  tags = {
    Name        = "${var.projectName}-nat-gateway-${var.env}"
    Environment = var.env
  }
}

#Manage a default route table of a VPC (Public Route Table)
resource "aws_default_route_table" "samar_default_rt" {
  default_route_table_id = aws_vpc.samar_vpc.default_route_table_id

  route {
    cidr_block = var.destination-cidr-block
    gateway_id = aws_internet_gateway.samar_ig.id
  }
  tags = {
    Name        = "${var.projectName}-default-rt-${var.env}"
    Environment = var.env
  }
}

#Create Private Route table
resource "aws_route_table" "samar_private_rt" {
  vpc_id = aws_vpc.samar_vpc.id

  route {
    cidr_block     = var.destination-cidr-block
    nat_gateway_id = aws_nat_gateway.samar_nat_gateway.id
  }
  tags = {
    Name        = "${var.projectName}-private-rt-${var.env}"
    Environment = var.env
  }
}



