
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um segredo no Secrets Manager
resource "aws_secretsmanager_secret" "example" {
  name = "my-secret"
  description = "This is an example secret"
}

# Crie uma versão do segredo
resource "aws_secretsmanager_secret_version" "example" {
  secret_id  = aws_secretsmanager_secret.example.id
  secret_string = "my-secret-value"
}
    