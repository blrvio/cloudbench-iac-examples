
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Create a Neptune cluster
resource "aws_neptune_cluster" "main" {
  cluster_identifier = "my-neptune-cluster"
  engine             = "neptune"
  engine_version     = "1.2.0"
  # Choose an instance type that supports Neptune
  instance_class = "db.r5.large"
  # Choose a subnet group
  subnet_group_name   = "my-neptune-subnet-group"
  # Choose a security group
  vpc_security_group_ids = [aws_security_group.main.id]
  # Enable deletion protection to prevent accidental deletion
  deletion_protection = false

  # Add tags for organization and management
  tags = {
    Name = "My Neptune Cluster"
  }
}

# Create a security group for Neptune access
resource "aws_security_group" "main" {
  name   = "sg-neptune"
  # Allow access from your IP address to the Neptune cluster
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow access from the Neptune cluster to itself
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a subnet group for Neptune
resource "aws_neptune_subnet_group" "main" {
  name       = "my-neptune-subnet-group"
  subnet_ids = [aws_subnet.main.id, aws_subnet.main2.id]
  # Choose a subnet group description
  description = "Subnet group for my Neptune cluster"
}

# Create subnets for the Neptune cluster
resource "aws_subnet" "main" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  # Add tags for organization and management
  tags = {
    Name = "Subnet 1"
  }
}

resource "aws_subnet" "main2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  # Add tags for organization and management
  tags = {
    Name = "Subnet 2"
  }
}

# Create a VPC for the Neptune cluster
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  # Add tags for organization and management
  tags = {
    Name = "My Neptune VPC"
  }
}

  