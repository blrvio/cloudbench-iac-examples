
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um Ledger
resource "aws_qldb_ledger" "example" {
  name = "example-ledger"
}

# Crie uma tabela
resource "aws_qldb_table" "example" {
  name     = "example-table"
  ledger_name = aws_qldb_ledger.example.name
  keys = ["id"]
}

# Crie um usuário
resource "aws_qldb_user" "example" {
  ledger_name = aws_qldb_ledger.example.name
  user_name  = "example-user"
  permissions = ["READ", "WRITE", "ADMIN"]
}

# Crie um driver de conexão
resource "aws_qldb_driver" "example" {
  ledger_name = aws_qldb_ledger.example.name
}

# Crie um certificado
resource "aws_qldb_certificate" "example" {
  ledger_name = aws_qldb_ledger.example.name
  certificate = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx" # Substitua pelo certificado
}
    