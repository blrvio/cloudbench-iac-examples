
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie uma tarefa de migração
resource "aws_application_migration_service_application" "example" {
  name     = "example-application"
  server_groups {
    # ...
  }
}

# Crie um servidor de migração
resource "aws_application_migration_service_server" "example" {
  name           = "example-server"
  instance_type = "t2.micro" # Substitua pelo tipo de instância desejado
  # ...
}

# Crie um servidor de migração
resource "aws_application_migration_service_server_group" "example" {
  name = "example-server-group"
  # ...
}
    