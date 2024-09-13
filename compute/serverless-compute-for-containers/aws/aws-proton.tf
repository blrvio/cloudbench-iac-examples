
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um serviço Proton
resource "proton_service" "my_service" {
  name = "my-service"
  service_instance_name = "my-service-instance"
  template {
    # Define o template do serviço
  }
}

# Crie um ambiente Proton
resource "proton_environment" "my_environment" {
  name = "my-environment"
  # Define as configurações do ambiente
}

# Crie uma pipeline Proton
resource "proton_pipeline" "my_pipeline" {
  name = "my-pipeline"
  service = proton_service.my_service.id
  environment = proton_environment.my_environment.id
  # Define a pipeline
}

    