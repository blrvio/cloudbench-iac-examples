
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16" # Define the VPC CIDR block
  enable_dns_hostnames = true          # Enable DNS hostnames
  enable_dns_support   = true          # Enable DNS support
  tags = {
    Name = "My VPC"
  }
}

# Create a subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24" # Define the subnet CIDR block
  availability_zone = "us-east-1a"  # Select an availability zone
  tags = {
    Name = "My Subnet"
  }
}

# Create a security group
resource "aws_security_group" "main" {
  name        = "sg-efa"
  description = "Security group for EFA instances"
  vpc_id      = aws_vpc.main.id
  # Allow inbound traffic from the same security group
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "tcp"
    self      = true
  }
  # Allow outbound traffic to all destinations
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EFA instance
resource "aws_instance" "efa" {
  ami                    = "ami-08c40ec972c57421d" # Choose a suitable AMI
  instance_type          = "c5n.18xlarge"          # Choose an instance type that supports EFA
  vpc_security_group_ids = [aws_security_group.main.id]
  subnet_id              = aws_subnet.main.id
  # Enable EFA support for the instance
  efa {
    enabled = true
  }
  tags = {
    Name = "My EFA Instance"
  }
}

  