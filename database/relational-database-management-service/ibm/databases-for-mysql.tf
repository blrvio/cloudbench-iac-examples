
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um instância do RDS para MySQL
resource "aws_db_instance" "mysql_instance" {
  allocated_storage = 10 # Substitua pelo tamanho do armazenamento desejado
  engine             = "mysql"
  engine_version     = "5.7.33" # Substitua pela versão do MySQL desejada
  instance_class     = "db.t3.micro" # Substitua pela classe de instância desejada
  identifier         = "mysql-instance"
  password           = "password" # Substitua pela senha desejada
  username           = "admin"
  db_subnet_group_name = "default"
}

# Crie um grupo de sub-redes para o RDS
resource "aws_db_subnet_group" "default" {
  name       = "default"
  subnet_ids = ["subnet-xxxxxxxx", "subnet-xxxxxxxx"] # Substitua pelos IDs das sub-redes desejadas
}
    