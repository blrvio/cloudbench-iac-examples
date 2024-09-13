
      # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Redis cluster
resource "aws_elasticache_cluster" "my_redis_cluster" {
  engine          = "redis"
  engine_version = "6.x"
  node_type       = "cache.t2.micro"
  num_node_groups = 1
  parameter_group_name = "default.redis6.x"
  port = 6379
  replication_mode = "single-node"
  security_group_ids = [aws_security_group.redis_sg.id]
  subnet_group_name = "my-redis-subnet-group"

  tags = {
    Name = "My Redis Cluster"
  }
}

# Create a security group to allow access to Redis
resource "aws_security_group" "redis_sg" {
  name = "redis_sg"
  description = "Security group for Redis"
  vpc_id = "vpc-xxxxxxxx" # Replace with your VPC ID

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a subnet group for Redis
resource "aws_elasticache_subnet_group" "my-redis-subnet-group" {
  name       = "my-redis-subnet-group"
  description = "Subnet group for Redis"
  subnet_ids = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] # Replace with your subnet IDs
}
    