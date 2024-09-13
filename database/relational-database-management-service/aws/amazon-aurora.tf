
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um cluster Aurora MySQL
resource "aws_db_cluster" "aurora_cluster" {
  cluster_identifier = "my-aurora-cluster"
  engine            = "aurora-mysql"
  engine_version   = "5.7.mysql_aurora.2.06.1"
  master_username   = "admin"
  master_password   = "password"
  database_name     = "mydb"
  # ... (rest of the configuration)
  # Use a smaller instance type for cost optimization
  # Use a dedicated subnet for security and network performance
}

# Crie um banco de dados no cluster Aurora
resource "aws_db_instance" "aurora_instance" {
  db_name = "mydb"
  # ... (rest of the configuration)
  # Use a smaller instance type for cost optimization
}

# Crie um endpoint para o cluster Aurora
resource "aws_db_cluster_endpoint" "aurora_endpoint" {
  cluster_identifier = aws_db_cluster.aurora_cluster.id
  db_cluster_endpoint_identifier = "my-aurora-endpoint"
  endpoint_type    = "READER"
  static_members  = [aws_db_instance.aurora_instance.id]
}

# Crie um endpoint para o cluster Aurora
resource "aws_db_cluster_endpoint" "aurora_endpoint" {
  cluster_identifier = aws_db_cluster.aurora_cluster.id
  db_cluster_endpoint_identifier = "my-aurora-endpoint"
  endpoint_type    = "READER"
  static_members  = [aws_db_instance.aurora_instance.id]
}
    