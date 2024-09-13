
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id"
}

# Crie um serviço Cloud Endpoints
resource "google_endpoints_service" "default" {
  name = "my-service"
  config {
    http {
      path {
        pattern = "/api/v1/*"
      }
    }
  }
}

# Crie uma configuração de roteamento para o serviço
resource "google_endpoints_service_routing_rule" "default" {
  service = google_endpoints_service.default.name
  address = "my-service-address"
}

# Crie uma configuração de validação de API
resource "google_endpoints_service_validation_rule" "default" {
  service = google_endpoints_service.default.name
  path = "/api/v1/users"
  methods = ["GET"]
  headers = ["Authorization"]
  query_parameters = ["name"]
  body_parameters = ["id"]
}

# Crie um serviço Cloud Endpoints para uma API existente
resource "google_endpoints_service" "existing_api" {
  name = "my-existing-api"
  config {
    grpc {
      path {
        pattern = "/api/v1/*"
      }
    }
  }
  existing_api {
    grpc {
      api_version = "v1"
      api_name = "my-existing-api"
    }
  }
}
    