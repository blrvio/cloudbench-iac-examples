
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an ElastiCache Cluster
resource "aws_elasticache_cluster" "main" {
  engine             = "redis"
  engine_version     = "6.2.6"
  node_type          = "cache.t2.micro"
  # Number of nodes in the cluster (default is 1)
  num_node_groups = 1
  # Define the cluster name
  cluster_name = "my-elasticache-cluster"
  # Define the security group for the cluster
  security_group_ids = [aws_security_group.main.id]
  # Set the subnet group for the cluster
  subnet_group_name = aws_elasticache_subnet_group.main.name

  # Optional settings
  # auto_minor_version_upgrade = true
  # port = 6379
  # snapshot_arns = ["arn:aws:elasticache:us-east-1:123456789012:snapshot:my-snapshot"]
}

# Create a Security Group
resource "aws_security_group" "main" {
  name   = "sg-elasticache"
  # Define the ingress and egress rules
  ingress {
    from_port   = 6379
    to_port     = 6379
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

# Create a Subnet Group
resource "aws_elasticache_subnet_group" "main" {
  name       = "my-elasticache-subnet-group"
  subnet_ids = [aws_subnet.main.id]
  # Optional settings
  # description = "My ElastiCache Subnet Group"
}

# Create a Subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  # Optional settings
  # map_public_ip_on_launch = true
  # tags = {
  #   Name = "My ElastiCache Subnet"
  # }
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  # Optional settings
  # enable_dns_hostnames = true
  # enable_dns_support = true
  # tags = {
  #   Name = "My ElastiCache VPC"
  # }
}

  