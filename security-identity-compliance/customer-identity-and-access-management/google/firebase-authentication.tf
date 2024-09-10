
    terraform { required_providers {
  google = {
    source  = "hashicorp/google"
    version = "~> 4.0"
  }
}
}

# Configure the Google provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Firebase project
resource "google_firebase_project" "main" {
  project_id = "your-firebase-project-id"
  # Optional: set the project display name
  display_name = "My Firebase Project"
}

# Create a Firebase Authentication provider
resource "google_firebase_auth_provider" "main" {
  project = google_firebase_project.main.project_id
  provider_id = "google.com"
  # Optional: Set the display name for the provider
  display_name = "Google"
}

  