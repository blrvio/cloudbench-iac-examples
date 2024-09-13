
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie uma instância RDS para MySQL
resource "aws_db_instance" "mysql_db" {
  allocated_storage = 10
  engine             = "mysql"
  engine_version     = "5.7.33"
  instance_class     = "db.t3.micro"
  name               = "mysql-db"
  username           = "admin"
  password           = "password"
  db_subnet_group_name = "mysql-subnet"
  # ... outras configurações
}

# Crie um grupo de sub-rede para o RDS
resource "aws_db_subnet_group" "mysql_subnet" {
  name       = "mysql-subnet"
  subnet_ids = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] # Substitua pelos IDs das suas sub-redes
}

# Crie um grupo de segurança para o RDS
resource "aws_db_security_group" "mysql_sg" {
  name = "mysql-sg"

  ingress {
    database_port    = 3306
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# Crie um usuário para o RDS
resource "aws_db_user" "mysql_user" {
  name     = "app_user"
  password = "password"
  database = "mydb"
  db_instance_identifier = aws_db_instance.mysql_db.id
}

# Crie um banco de dados para o RDS
resource "aws_db_instance" "mydb" {
  name = "mydb"
  db_instance_identifier = aws_db_instance.mysql_db.id
}
    