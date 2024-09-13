
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um namespace para o Cloud Map
resource "aws_service_discovery_namespace" "example" {
  name = "example-namespace"
  type = "DNS_PRIVATE"
}

# Crie um serviço no Cloud Map
resource "aws_service_discovery_service" "example" {
  name = "example-service"
  namespace_id = aws_service_discovery_namespace.example.id
  dns_config {
    dns_records {
      type = "SRV"
    }
  }
  health_check_config {
    failure_threshold = 2
    type = "HTTP"
    resource_path = "/health"
  }
}

# Crie uma instância de serviço
resource "aws_service_discovery_instance" "example" {
  service_id = aws_service_discovery_service.example.id
  instance_id = "example-instance"
  attributes = {
    "AWS_INSTANCE_IPV4" = "10.0.0.1"
    "AWS_INSTANCE_PORT" = "80"
  }
}
    