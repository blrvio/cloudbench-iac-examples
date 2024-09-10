
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create the first VPC
resource "aws_vpc" "first" {
  cidr_block = "10.0.0.0/16" # Define the CIDR block for the VPC
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "First VPC"
  }
}

# Create the second VPC
resource "aws_vpc" "second" {
  cidr_block = "172.16.0.0/16" # Define the CIDR block for the VPC
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "Second VPC"
  }
}

# Create an internet gateway for the first VPC
resource "aws_internet_gateway" "first" {
  vpc_id = aws_vpc.first.id
}

# Create a subnet for the first VPC
resource "aws_subnet" "first" {
  vpc_id = aws_vpc.first.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "First Subnet"
  }
}

# Create a route table for the first VPC
resource "aws_route_table" "first" {
  vpc_id = aws_vpc.first.id
  tags = {
    Name = "First Route Table"
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "first" {
  route_table_id = aws_route_table.first.id
  subnet_id = aws_subnet.first.id
}

# Create a route to the internet gateway
resource "aws_route" "first" {
  route_table_id = aws_route_table.first.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.first.id
}

# Create an internet gateway for the second VPC
resource "aws_internet_gateway" "second" {
  vpc_id = aws_vpc.second.id
}

# Create a subnet for the second VPC
resource "aws_subnet" "second" {
  vpc_id = aws_vpc.second.id
  cidr_block = "172.16.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Second Subnet"
  }
}

# Create a route table for the second VPC
resource "aws_route_table" "second" {
  vpc_id = aws_vpc.second.id
  tags = {
    Name = "Second Route Table"
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "second" {
  route_table_id = aws_route_table.second.id
  subnet_id = aws_subnet.second.id
}

# Create a route to the internet gateway
resource "aws_route" "second" {
  route_table_id = aws_route_table.second.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.second.id
}

# Create the VPC peering connection
resource "aws_vpc_peering_connection" "main" {
  accepter_vpc_id = aws_vpc.second.id
  requester_vpc_id = aws_vpc.first.id
  auto_accept = true
  tags = {
    Name = "VPC Peering Connection"
  }
}

# Create a route for the VPC peering connection
resource "aws_route" "peering_route" {
  route_table_id = aws_route_table.first.id
  destination_cidr_block = aws_vpc.second.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.main.id
}

  