
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Choose a desired region
}

# Create a Cloud Run service
resource "google_cloud_run_v2_service" "main" {
  name     = "my-cloud-run-service"
  location = "us-central1"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
  # Optional: Add traffic configurations for blue-green deployments
  traffic {
    latest_revision = true
    percent         = 100
  }
}

# Create a Cloud Storage bucket for storing data
resource "google_storage_bucket" "main" {
  name     = "my-cloud-storage-bucket"
  location = "US"
  # Optional: Configure access control policies
  force_destroy = true
}

  