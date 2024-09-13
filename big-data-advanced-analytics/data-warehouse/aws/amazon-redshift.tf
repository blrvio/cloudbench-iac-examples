
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cluster Redshift
resource "aws_redshift_cluster" "main" {
  cluster_identifier  = "my-redshift-cluster"
  cluster_type       = "dc2.large"
  master_username      = "admin"
  master_password      = "password"
  database_name       = "my_database"
  publicly_accessible = false
  # Substitua pelo número do subnet desejado
  subnet_group_name  = "my-redshift-subnet-group"
}

# Crie um grupo de subnet Redshift
resource "aws_redshift_subnet_group" "main" {
  name        = "my-redshift-subnet-group"
  description = "Subnet group for Redshift cluster"
  subnet_ids  = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"]
  # Substitua pelos IDs das subnets desejadas
}

# Crie uma tabela Redshift
resource "aws_redshift_table" "main" {
  cluster_identifier = aws_redshift_cluster.main.cluster_identifier
  database           = "my_database"
  table_name         = "my_table"
  # Defina os campos da tabela
  columns = <<COLUMNS
  id INT PRIMARY KEY,
  name VARCHAR(255),
  created_at TIMESTAMP
COLUMNS
}

    