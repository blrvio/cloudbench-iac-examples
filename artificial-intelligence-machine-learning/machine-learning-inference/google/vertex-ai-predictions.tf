
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Change to your desired region
}

# Create a Vertex AI Endpoint
resource "google_vertex_ai_endpoint" "main" {
  name     = "my-vertex-ai-endpoint"
  location = google_vertex_ai_endpoint.main.location
  # Create a Vertex AI Model
  resource "google_vertex_ai_model" "main" {
    display_name      = "my-vertex-ai-model"
    location          = google_vertex_ai_endpoint.main.location
    description      = "My Vertex AI Model"
    # Create a Vertex AI Model Deployment
    resource "google_vertex_ai_model_deployment" "main" {
      display_name = "my-vertex-ai-model-deployment"
      endpoint    = google_vertex_ai_endpoint.main.name
      model       = google_vertex_ai_model.main.name
      deployed_model {
        dedicated_resources {
          min_replica_count = 1
          max_replica_count = 2
        }
      }
    }
  }
}

  