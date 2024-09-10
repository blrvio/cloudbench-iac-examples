
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Cloud Run service
resource "google_cloud_run_v2_service" "main" {
  name     = "my-cloud-run-service"
  location = google_cloud_run_v2_service.main.location
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
    # Use a default traffic split
    traffic {
      percent  = 100
      latest_revision = true
    }
  }
}

  