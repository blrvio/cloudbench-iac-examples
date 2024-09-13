
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id" # Substitua pelo seu ID do projeto
  region  = "us-central1" # Substitua pela sua região desejada
}

# Crie um alerta de monitoramento
resource "google_monitoring_alert_policy" "my_alert" {
  display_name = "My Alert"
  # ...
}

# Crie um dashboard de monitoramento
resource "google_monitoring_dashboard" "my_dashboard" {
  display_name = "My Dashboard"
  # ...
}
    