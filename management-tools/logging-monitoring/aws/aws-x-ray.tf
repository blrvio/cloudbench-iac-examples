
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um perfil de amostragem do X-Ray
resource "aws_xray_sampling_rule" "default" {
  name = "default"
  rule {
    # Regras de amostragem customizadas
    # Consulte a documentação do X-Ray para obter mais informações
  }
}

# Crie uma regra de instrumentação do X-Ray
resource "aws_xray_encryption_config" "default" {
  # Configurações de criptografia customizadas
  # Consulte a documentação do X-Ray para obter mais informações
}
    