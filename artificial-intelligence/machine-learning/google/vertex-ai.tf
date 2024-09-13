
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id"
  region  = "us-central1"
}

# Crie um recurso de Modelo de Machine Learning no Vertex AI
resource "google_vertex_ai_model" "my_model" {
  name     = "my-model"
  display_name = "My Model"
  description = "My custom trained model"
  version_id = "1"
  
  artifact_uri = "gs://my-bucket/models/my-model/1"
}

# Crie um Endpoint para servir o modelo
resource "google_vertex_ai_endpoint" "my_endpoint" {
  name     = "my-endpoint"
  display_name = "My Endpoint"
  description = "Endpoint para servir o modelo"
  
  machine_type = "n1-standard-1"
  
  deployed_models {
    model = google_vertex_ai_model.my_model.name
    model_version_id = google_vertex_ai_model.my_model.version_id
  }
}

# Crie um Job de treinamento de modelo
resource "google_vertex_ai_training_job" "my_training_job" {
  name     = "my-training-job"
  display_name = "My Training Job"
  description = "Job de treinamento para o meu modelo"
  
  training_method {
    container_spec {
      image_uri = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
  
  model_definition {
    model {
      name = google_vertex_ai_model.my_model.name
    }
  }
}


    