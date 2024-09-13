
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um servidor de transferência
resource "aws_transfer_server" "main" {
  endpoint_type = "SFTP"
  hostname      = "example.com"
  # ...
}

# Crie um usuário de transferência
resource "aws_transfer_user" "main" {
  server_id = aws_transfer_server.main.id
  # ...
}

# Crie uma chave de segurança
resource "aws_transfer_ssh_key" "main" {
  server_id = aws_transfer_server.main.id
  # ...
}
    