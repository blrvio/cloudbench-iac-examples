
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cluster MongoDB
resource "aws_db_cluster" "mongodb_cluster" {
  engine = "mongodb"
  engine_version = "4.0"
  cluster_identifier = "my-mongodb-cluster"
  database_name = "mydatabase"
  password = "mypassword"

  # Opções de configuração adicionais
}

# Crie um endpoint para o cluster MongoDB
resource "aws_db_cluster_endpoint" "mongodb_endpoint" {
  cluster_identifier = aws_db_cluster.mongodb_cluster.id
  endpoint_type = "READER"
  static_members = [aws_db_instance.mongodb_instance.db_instance_identifier]
}

# Crie uma instância MongoDB
resource "aws_db_instance" "mongodb_instance" {
  engine = "mongodb"
  engine_version = "4.0"
  db_instance_identifier = "my-mongodb-instance"
  db_instance_class = "db.t3.micro"
  database_name = "mydatabase"
  password = "mypassword"
  cluster_identifier = aws_db_cluster.mongodb_cluster.id

  # Opções de configuração adicionais
}
    