
      terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  credentials = file("path/to/credentials.json")
  project     = "your-gcp-project-id"
  region      = "us-central1"
}

resource "google_service_account" "default" {
  account_id   = "sa-cloud-run-xxxxxxxx"
  display_name = "Cloud Run Service Account"
}

resource "google_project_iam_member" "service_account" {
  project  = "your-gcp-project-id"
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.default.email}"
}

resource "google_cloud_run_v2_service" "default" {
  autogenerate_revision_name = true
  location                      = "us-central1"
  name                          = "hello-world"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }
    timeout_seconds = 120
  }
  traffic {
    latest_revision = true
    percent         = 100
  }
}

    