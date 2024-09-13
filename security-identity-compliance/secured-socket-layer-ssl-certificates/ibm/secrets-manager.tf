
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um segredo no Secrets Manager
resource "aws_secretsmanager_secret" "example" {
  name = "example"
  description  = "Exemplo de segredo"
}

# Adicione um valor ao segredo
resource "aws_secretsmanager_secret_version" "version" {
  secret_id  = aws_secretsmanager_secret.example.id
  secret_string = "senha_secreta"
  version_stages = ["AWSCURRENT"]
}

# Acesse o valor do segredo
output "secret_value" {
  value = aws_secretsmanager_secret_version.version.secret_string
}
    