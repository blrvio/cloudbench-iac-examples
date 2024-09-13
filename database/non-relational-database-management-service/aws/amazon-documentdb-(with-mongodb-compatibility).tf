
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cluster DocumentDB
resource "aws_docdb_cluster" "main" {
  cluster_identifier = "docdb-cluster"
  engine             = "mongodb"
  engine_version     = "4.0"
  # ...
}

# Crie um usuário DocumentDB
resource "aws_docdb_user" "admin" {
  cluster_identifier = aws_docdb_cluster.main.id
  username          = "admin"
  password          = "password"
  # ...
}

# Crie um endpoint DocumentDB
resource "aws_docdb_cluster_endpoint" "main" {
  cluster_identifier = aws_docdb_cluster.main.id
  endpoint_type       = "READER"
  # ...
}
    