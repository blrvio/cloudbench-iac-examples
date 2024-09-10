
    # Configure the Google Cloud provider
provider "google" {
  project = "my-gcp-project"
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
  }
  autogenerate_revision_name = true
}

  