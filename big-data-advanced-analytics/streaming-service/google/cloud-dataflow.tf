
      # Configure o provedor Google Cloud
provider "google" {
  project = "gcp-project-id"
  region  = "us-central1"
}

# Crie um pipeline Dataflow
resource "google_dataflow_job" "my_pipeline" {
  name     = "my-pipeline"
  project  = "gcp-project-id"
  location = "us-central1"
  template = "gs://dataflow-templates/latest/WordCount"
  # ... other configurations
}
    