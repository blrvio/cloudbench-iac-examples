
      # Configure o provedor Google Cloud
provider "google" {
  project = "gcp-project-id"
  region  = "us-central1"
}

# Crie uma instância do Cloud Data Fusion
resource "google_data_fusion_instance" "default" {
  name     = "data-fusion-instance"
  location = google_data_fusion_instance.default.location
  version  = "latest"
  network  = "projects/gcp-project-id/global/networks/default"
  # Opcional: adicione recursos para a instância
  # resources = [ "cloud-sql", "bigquery", "pubsub", "gcs" ]
}

    