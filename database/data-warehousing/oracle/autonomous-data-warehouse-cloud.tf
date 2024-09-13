
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma instância do Autonomous Data Warehouse
resource "aws_db_instance" "adw" {
  allocated_storage = 100
  engine            = "oracle-se2"
  engine_version     = "19.0.0.0.0"
  db_subnet_group_name = "adw-subnet"
  db_name             = "adw_db"
  username           = "admin"
  password           = "password"
  storage_type        = "standard"
  deletion_protection  = false
  skip_final_snapshot = true
  tags               = {
    Name = "adw_instance"
  }
}
    