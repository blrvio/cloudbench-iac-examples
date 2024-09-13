
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um serviço App Runner
resource "aws_apprunner_service" "my_service" {
  source {
    image_repository {
      image_repository_url = "<container_image_repository_url>" # Substitua pela URL do repositório de imagens
      image_config {
        port = 8080
      }
    }
  }
  auto_scaling_configuration_arn = "<auto_scaling_configuration_arn>" # Substitua pelo ARN da configuração de autoescalabilidade
  network_configuration {
    egress {
      access_type = "INTERNET" # Substitua pelo tipo de acesso desejado
    }
  }
  tags = {
    Name = "My App Runner Service"
  }
}
    