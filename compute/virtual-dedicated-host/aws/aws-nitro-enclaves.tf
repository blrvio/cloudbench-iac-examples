
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16" # Replace with your desired CIDR block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "My VPC"
  }
}

# Create a subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a" # Replace with your desired Availability Zone
  tags = {
    Name = "My Subnet"
  }
}

# Create a security group
resource "aws_security_group" "main" {
  name   = "sg-nitro-enclave"
  vpc_id = aws_vpc.main.id
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

# Create an EC2 instance with Nitro Enclaves enabled
resource "aws_instance" "main" {
  ami           = "ami-08c40ec972c57421d" # Replace with your desired AMI
  instance_type = "t3.xlarge"
  key_name      = "my-key-pair"
  subnet_id     = aws_subnet.main.id
  # Enable Nitro Enclaves
  enclave_options {
    enabled = true
  }
  vpc_security_group_ids = [aws_security_group.main.id]
  tags = {
    Name = "My Nitro Enclave Instance"
  }
}

  