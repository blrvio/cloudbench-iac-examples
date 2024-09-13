
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cluster do RDS
resource "aws_db_cluster" "example" {
  cluster_identifier = "example"
  engine            = "postgres"
  engine_version     = "13.4"
  database_name     = "mydb"
  master_username    = "admin"
  master_password    = "password"
  # ...
}

# Crie um sub-rede para o cluster
resource "aws_db_subnet_group" "example" {
  name       = "example"
  subnet_ids = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] # Substitua pelos IDs das suas sub-redes
  # ...
}

# Crie uma instância do RDS
resource "aws_db_instance" "example" {
  db_cluster_identifier = aws_db_cluster.example.id
  allocated_storage       = 10
  engine                  = "postgres"
  engine_version          = "13.4"
  db_subnet_group_name    = aws_db_subnet_group.example.name
  # ...
}
    