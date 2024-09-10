
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create an Error Reporting service
resource "google_error_reporting_service" "main" {
  service  = "your-service-name"
  project = "your-project-id"
}

  