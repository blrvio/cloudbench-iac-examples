
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um cluster RDS para MySQL Heatwave
resource "aws_db_cluster" "mysql_heatwave" {
  cluster_identifier = "mysql-heatwave-cluster"
  engine             = "mysql"
  engine_version     = "8.0.27"
  master_username    = "admin"
  master_password    = "password"
  database_name       = "my_database"
  skip_final_snapshot = true

  # Configure o recurso Heatwave
  heatwave {
    enabled    = true
    node_type = "h1.2xlarge"
    scale_capacity = 2
  }

  # Configure a instância do banco de dados
  db_subnet_group_name = "my-subnet-group"

  # Configurações de segurança
  # Substitua pelo seu VPC ID
  vpc_security_group_ids = ["sg-xxxxxxxx"]
}

# Crie um grupo de sub-redes para o cluster RDS
resource "aws_db_subnet_group" "my_subnet_group" {
  db_subnet_group_name = "my-subnet-group"
  subnet_ids           = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"]
  # Substitua pelo seu VPC ID
  vpc_id               = "vpc-xxxxxxxx"
}
    