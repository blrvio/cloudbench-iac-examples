
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cluster Redis
resource "aws_elasticache_cluster" "my_redis_cluster" {
  engine          = "redis"
  engine_version  = "6.x"
  node_type       = "cache.t2.small"
  num_node_groups = 1
  replication_mode = "cluster"

  cluster_mode {
    num_node_groups  = 1
    replicas_per_node_group = 1
  }

  tags = {
    Name = "My Redis Cluster"
  }
}

# Crie um grupo de segurança para permitir o acesso ao cluster Redis
resource "aws_security_group" "redis_sg" {
  name   = "redis_sg"
  vpc_id = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Associe o grupo de segurança ao cluster Redis
resource "aws_elasticache_cluster" "redis_sg_association" {
  cluster_id = aws_elasticache_cluster.my_redis_cluster.id
  security_group_ids = [aws_security_group.redis_sg.id]
}
    