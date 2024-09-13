
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id"
  region  = "us-central1"
}

# Crie um cluster Anthos
resource "google_anthos_cluster" "example" {
  name     = "my-anthos-cluster"
  location = google_anthos_cluster.example.location

  config {
    project = "gcp-project-id"
    zone    = "us-central1-a"
  }
}
    