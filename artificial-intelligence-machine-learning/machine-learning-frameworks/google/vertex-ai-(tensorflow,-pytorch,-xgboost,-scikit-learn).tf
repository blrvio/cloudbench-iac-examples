
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id"
  region  = "us-central1"
}

# Crie um modelo de treinamento de Vertex AI
resource "google_vertex_ai_model" "my_model" {
  display_name = "my-model"
  description  = "Modelo de treinamento de exemplo"
  model {
    artifact_uri = "gs://my-bucket/my-model"
  }
}

# Crie um endpoint de Vertex AI para servir o modelo
resource "google_vertex_ai_endpoint" "my_endpoint" {
  display_name = "my-endpoint"
  description  = "Endpoint de serviço de exemplo"
  deployed_models {
    model = google_vertex_ai_model.my_model.name
  }
  machine_type = "n1-standard-1"
}

    