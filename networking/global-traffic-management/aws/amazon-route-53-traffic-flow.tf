
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um Traffic Flow
resource "aws_route53_traffic_flow" "example" {
  name         = "example"
  hosted_zone_id = "Zxxxxxxxx" # Substitua pelo ID da sua Hosted Zone
  endpoint_types = ["HTTP"]
  instance {
    endpoint {
      address = "example.com"
      port = 80
    }
    conditions {
      match {
        http_header {
          name  = "User-Agent"
          value = "Chrome"
        }
      }
    }
    target_type = "Custom"
    target {
      custom_target {
        type = "Forwarding"
        targets = ["xxxxxxxx"] # Substitua pelo endpoint de destino
      }
    }
  }
}

    