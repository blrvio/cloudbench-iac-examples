
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id" # Substitua pelo ID do seu projeto
  region  = "us-central1" # Substitua pela sua região desejada
}

# Crie um serviço do Identity-Aware Proxy
resource "google_iap_web_backend_service" "default" {
  name     = "iap-backend-service"
  project  = "gcp-project-id"
  backend  = "https://my-app.example.com"
}

# Crie uma configuração de acesso ao serviço do IAP
resource "google_iap_web_iam_binding" "default" {
  project  = "gcp-project-id"
  members  = ["allUsers"]
  role     = "roles/iap.httpsResourceAccessor"

  iap_web_backend_service = google_iap_web_backend_service.default.id
}
    