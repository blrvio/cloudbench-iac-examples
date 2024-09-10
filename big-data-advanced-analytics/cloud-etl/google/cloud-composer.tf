
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Cloud Composer Environment
resource "google_composer_environment" "main" {
  name     = "composer-env"
  location = "us-central1"
  # Configure the Airflow version
  airflow_version = "2.2.4"
  # Configure the Node pool
  node_config {
    machine_type = "n1-standard-1"
    disk_size_gb  = 100
  }
  # Enable access control for the environment
  enable_airflow_ui = true
  # Configure the Cloud Storage bucket
  # Use an existing bucket or create a new one
  # Optional - Set the Cloud Storage bucket if you're not using the default
  # cloud_storage_config {
  #   bucket = "your-cloud-storage-bucket"
  # }
  # Optional - Enable access logging for the environment
  # access_config {
  #   logging_enabled = true
  # }
}

# Optional - Create a Cloud Storage bucket for the environment
# resource "google_storage_bucket" "main" {
#   name    = "composer-bucket"
#   location = "US"
#   force_destroy = true
# }

# Optional - Create a service account for the environment
# resource "google_service_account" "main" {
#   account_id   = "composer-sa"
#   display_name = "Composer Service Account"
#   disabled     = false
# }

# Optional - Grant the service account permission to access the Cloud Storage bucket
# resource "google_storage_bucket_iam_member" "main" {
#   bucket  = google_storage_bucket.main.name
#   role    = "roles/storage.objectViewer"
#   member  = "serviceAccount:${google_service_account.main.email}"
# }

  