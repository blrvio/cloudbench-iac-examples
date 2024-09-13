
      terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = "gcp-project-id"
  region  = "us-central1"
}

# Create a Cloud Run service
resource "google_cloud_run_v2_service" "default" {
  location = google_cloud_run_v2_location.default.name
  name     = "cloud-run-service"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
}

# Create a location
resource "google_cloud_run_v2_location" "default" {
  location = "us-central1"
}

    