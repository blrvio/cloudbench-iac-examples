
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um recurso de Migration Hub
resource "aws_migrationhub_home_region_control" "example" {
  home_region = "us-east-1" # Substitua pela sua região principal
}

# Crie uma configuração de migração para um servidor
resource "aws_migrationhub_configuration" "example" {
  name = "example"
  
  application_discovery_service_configuration {
    name = "example"
  }

  aws_services_configuration {
    name = "example"
  }
}

# Registre um servidor na Migration Hub
resource "aws_migrationhub_registered_server" "example" {
  configuration_id  = aws_migrationhub_configuration.example.id
  server_id        = "server-id"
  server_type       = "EC2"
  discovery_time = "2022-01-01T00:00:00Z"
}

    