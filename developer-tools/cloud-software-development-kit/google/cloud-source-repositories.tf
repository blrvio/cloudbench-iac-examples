
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a Cloud Source Repository
resource "google_source_repository" "main" {
  name    = "my-repository"
  project = "your-project-id"
}

# Create a Cloud Source Repository webhook
resource "google_source_repository_webhook" "main" {
  name     = "my-webhook"
  repository = google_source_repository.main.name
  project     = "your-project-id"
  config {
    url   = "https://your-webhook-endpoint"
    secret = "your-webhook-secret"
  }
  event_type = "PUSH"
}

  