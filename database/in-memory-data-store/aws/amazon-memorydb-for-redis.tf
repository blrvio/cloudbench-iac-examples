
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cluster MemoryDB
resource "aws_memorydb_cluster" "main" {
  engine_version = "6.x"
  name           = "my-memorydb-cluster"
  node_type      = "cache.t2.medium"
  num_nodes       = 2
  security_group_ids = [aws_security_group.allow_access.id]
  parameter_group_name  = "default.memorydb6.x.cluster.parameter.group.name"
}

# Crie um sub-rede para o cluster
resource "aws_memorydb_subnet_group" "main" {
  name       = "my-memorydb-subnet-group"
  subnet_ids = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"]
}

# Crie um grupo de segurança para permitir o acesso
resource "aws_security_group" "allow_access" {
  name   = "allow_access"
  vpc_id = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Substitua pelo CIDR desejado
  }
}

# Crie um usuário MemoryDB
resource "aws_memorydb_user" "main" {
  cluster_name = aws_memorydb_cluster.main.name
  user_name    = "my-user"
  password     = "my-password" # Substitua por uma senha forte
}

# Crie uma permissão para o usuário
resource "aws_memorydb_user_group" "main" {
  cluster_name = aws_memorydb_cluster.main.name
  name          = "my-group"
  user_names    = [aws_memorydb_user.main.user_name]
}

# Crie uma permissão para o usuário
resource "aws_memorydb_user_permission" "main" {
  cluster_name   = aws_memorydb_cluster.main.name
  user_group_name = aws_memorydb_user_group.main.name
  read           = true
  write          = true
}
    