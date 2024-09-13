
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cluster do Cloud MemoryStore for Redis
resource "aws_memorydb_cluster" "example" {
  engine             = "redis"
  engine_version     = "6.x"
  node_type          = "cache.t2.small"
  num_shards         = 1
  snapshot_retention_limit = 0 # Define o limite de retenção de snapshots
  snapshot_window      = "05:00-09:00" # Define a janela de criação de snapshots
  security_group_ids    = [aws_security_group.example.id] # Adicione um grupo de segurança para o cluster
  tags               = {
    Name = "Cloud MemoryStore Cluster"
  }
}

# Crie um grupo de segurança para o cluster do Cloud MemoryStore
resource "aws_security_group" "example" {
  name   = "memorydb_security_group"
  vpc_id = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC
  ingress {
    from_port   = 6379 # Porta padrão para Redis
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permite acesso de qualquer IP
  }
}

    