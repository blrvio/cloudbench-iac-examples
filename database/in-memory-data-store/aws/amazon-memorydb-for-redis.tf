
# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a MemoryDB cluster
resource "aws_memorydb_cluster" "main" {
  engine               = "redis"
  engine_version       = "6.x"
  node_type            = "cache.t2.small"
  num_nodes            = 2
  parameter_group_name = "default.memorydb.parameter.group.redis6.x"
  subnet_group_name    = aws_memorydb_subnet_group.main.name
  tags = {
    Name = "My MemoryDB Cluster"
  }

  # Define a custom authentication password
  auth_token = "your_password"
}

# Create a MemoryDB subnet group
resource "aws_memorydb_subnet_group" "main" {
  name        = "my-memorydb-subnet-group"
  subnet_ids  = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  description = "Subnet group for MemoryDB cluster"
}

# Create two subnets
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "MemoryDB Subnet 1"
  }
}
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "MemoryDB Subnet 2"
  }
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "My MemoryDB VPC"
  }
}

  