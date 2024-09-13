
      # Configure o provedor do Google Cloud
provider "google" {
  project = "my-project-id"
}

# Crie um IAP serviço de proteção
resource "google_iap_web_backend_service" "default" {
  name     = "default"
  backend  = "my-backend-service"
  disable  = false
  port_name = "http"
}

# Crie um IAP serviço de proteção
resource "google_iap_tunnel_destination" "default" {
  name     = "default"
  address  = "10.128.0.1"
  port     = 8080
  disable  = false
  service  = "my-service-id"
}

    