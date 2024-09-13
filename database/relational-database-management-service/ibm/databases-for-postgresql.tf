
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um cluster do RDS para PostgreSQL
resource "aws_db_instance" "postgres_db" {
  allocated_storage = 10
  db_name          = "postgres"
  db_subnet_group_name = "default"
  engine           = "postgres"
  engine_version   = "13.5"
  instance_class    = "db.t3.micro"
  password         = "password"
  username         = "postgres"

  # Opções de configuração adicionais
  # ...

  tags = {
    Name = "PostgreSQL Database"
  }
}
    