
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id"
  region  = "us-central1" # Substitua pela sua região desejada
}

# Crie um modelo do Vertex AI
resource "google_vertex_ai_model" "model" {
  name     = "my-model"
  location = google_vertex_ai_endpoint.endpoint.location
  display_name = "My Model"
  description  = "Modelo de predição"
  
  # Use a imagem de modelo pré-treinado
  #   image_uri = "google/cloud-aiplatform/prediction/1.0"
  # Use o modelo do Vertex AI já treinado
  #   model_version = google_vertex_ai_model_version.model_version.name
}

# Crie um endpoint do Vertex AI
resource "google_vertex_ai_endpoint" "endpoint" {
  name     = "my-endpoint"
  location = "us-central1"
  display_name = "My Endpoint"
  description  = "Endpoint de predição"
}

# Crie uma versão do modelo do Vertex AI
resource "google_vertex_ai_model_version" "model_version" {
  name = "my-model-version"
  model = google_vertex_ai_model.model.name
  display_name = "My Model Version"
  description  = "Versão do modelo de predição"
  
  # Definir a configuração de predição
  #   prediction_config {
  #     machine_type  = "n1-standard-1"
  #     accelerator_type = "NVIDIA_TESLA_T4"
  #   }
}

# Implantar a versão do modelo no endpoint
resource "google_vertex_ai_endpoint_deployment" "deployment" {
  endpoint   = google_vertex_ai_endpoint.endpoint.name
  model_version = google_vertex_ai_model_version.model_version.name
}

# Realizar uma predição
resource "google_vertex_ai_prediction_service" "prediction" {
  endpoint = google_vertex_ai_endpoint.endpoint.name

  #   instances = [{"features": {}}]
}

    