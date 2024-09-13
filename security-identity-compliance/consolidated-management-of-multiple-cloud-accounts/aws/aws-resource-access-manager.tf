
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um compartilhamento de recursos
resource "aws_ram_resource_share" "example" {
  name         = "example"
  allow_external_principals = true
  resource_type = "aws:ec2:instance"
  # Omit long string
  # ...
}

# Adicione uma conta à lista de destinatários do compartilhamento
resource "aws_ram_resource_share_permission" "example" {
  resource_share_id = aws_ram_resource_share.example.id
  principal       = "123456789012" # Substitua pelo ID da conta
}

# Desconecte uma conta do compartilhamento de recursos
resource "aws_ram_resource_share_permission" "remove" {
  resource_share_id = aws_ram_resource_share.example.id
  principal       = "123456789012" # Substitua pelo ID da conta
  force           = true
}

# Exclua um compartilhamento de recursos
resource "aws_ram_resource_share" "remove" {
  name = "example"
  force = true
}
    