
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16" # Set the CIDR block for your VPC

  # Enable DNS Hostnames and DNS Resolution
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Add tags for identification
  tags = {
    Name = "My VPC"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id # Associate the internet gateway with the VPC
}

# Create a Subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id # The VPC to which the subnet belongs
  cidr_block        = "10.0.1.0/24"   # The CIDR block for the subnet
  availability_zone = "us-east-1a"    # Choose an availability zone

  # Add tags for identification
  tags = {
    Name = "My Subnet"
  }
}

# Create a Route Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id # The VPC to which the route table belongs

  # Create a route for traffic to the internet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

# Create a Security Group
resource "aws_security_group" "main" {
  name   = "My Security Group"
  vpc_id = aws_vpc.main.id # The VPC for the security group

  # Define inbound and outbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  