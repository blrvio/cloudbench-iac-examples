
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um grupo de segurança para o banco de dados
resource "aws_db_instance" "postgres_db" {
  allocated_storage = 10
  engine            = "postgres"
  engine_version    = "13.7"
  instance_class    = "db.t3.micro"
  name              = "postgres_db"
  password          = "password123" # Substitua por uma senha forte
  username          = "admin"
  # vpc_security_group_ids = [aws_security_group.postgres_sg.id]
  db_subnet_group_name = "default"
  # ... (Outras configurações)
}

# Crie um grupo de segurança para o banco de dados
resource "aws_security_group" "postgres_sg" {
  name = "postgres_sg"
  vpc_id = "vpc-xxxxxxxx" # Substitua pelo ID da sua VPC

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Substitua por seus IPs permitidos
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

    