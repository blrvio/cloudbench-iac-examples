
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um cluster do Neptune
resource "aws_neptune_cluster" "main" {
  cluster_identifier = "neptune-cluster"
  engine            = "neptune"
  engine_version    = "1.2.0.0"
  instance_class     = "db.t3.medium"
  db_subnet_group_name = "default"

  # Definir o usuário e a senha do cluster
  # Substituir esses valores por suas credenciais reais
  # credentials {
  #   username = "admin"
  #   password = "password"
  # }

  # Definir as tags do cluster
  # tags = {
  #   Name = "My Neptune Cluster"
  # }
}

# Crie um endpoint de leitura para o cluster do Neptune
resource "aws_neptune_cluster_instance" "reader" {
  cluster_identifier = aws_neptune_cluster.main.cluster_identifier
  apply_immediately  = true
  engine             = "neptune"
  instance_class     = "db.t3.small"
  # Definir a senha do endpoint de leitura
  # Substituir esse valor pela sua senha real
  # password = "password"
}

# Crie um endpoint de gravação para o cluster do Neptune
resource "aws_neptune_cluster_instance" "writer" {
  cluster_identifier = aws_neptune_cluster.main.cluster_identifier
  apply_immediately  = true
  engine             = "neptune"
  instance_class     = "db.t3.medium"
  # Definir a senha do endpoint de gravação
  # Substituir esse valor pela sua senha real
  # password = "password"
}
    