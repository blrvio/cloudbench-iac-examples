
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um novo chave KMS
resource "aws_kms_key" "example" {
  description = "Chave KMS para exemplo"
  enable_key_rotation = true
}

# Crie uma alias para a chave KMS
resource "aws_kms_alias" "example" {
  name = "alias/example"
  target_key_id = aws_kms_key.example.key_id
}
    