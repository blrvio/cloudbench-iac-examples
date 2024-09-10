
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Adjust based on your region
}

# Create a Vertex AI Endpoint
resource "google_vertex_ai_endpoint" "main" {
  display_name = "my-vertex-ai-endpoint"
  location     = "us-central1"
  
  # Define the machine type for the endpoint
  machine_type = "n1-standard-1"
  
  # Attach the model to the endpoint
  model {
    model = google_vertex_ai_model.main.id # ID of the model to deploy
  }
}

# Create a Vertex AI Model
resource "google_vertex_ai_model" "main" {
  display_name = "my-vertex-ai-model"
  location     = "us-central1"
  
  # Define the container image to use for the model
  container_spec {
    image_uri = "us-docker.pkg.dev/cloud-aiplatform/example-models/mnist_keras_cpu:latest"
  }
}

  