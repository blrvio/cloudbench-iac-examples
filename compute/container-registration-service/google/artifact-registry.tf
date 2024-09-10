
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create an Artifact Registry repository
resource "google_artifact_registry_repository" "main" {
  location = "us-central1"
  project  = "your-project-id"
  repository = "my-repo"
  format    = "DOCKER"
}

# Create an Artifact Registry IAM binding
resource "google_project_iam_member" "artifact_registry_admin" {
  project = "your-project-id"
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:your-service-account@gcp-sa-artifactregistry.iam.gserviceaccount.com"
}

# Create a service account
resource "google_service_account" "artifact_registry_sa" {
  account_id = "artifact-registry-sa"
  display_name = "Artifact Registry Service Account"
  disabled = false
}

# Create a key for the service account
resource "google_service_account_key" "artifact_registry_sa_key" {
  service_account_id = google_service_account.artifact_registry_sa.account_id
  project             = "your-project-id"
  # Suppressing the key to avoid storing it in the code
  private_key_type   = "TYPE_GOOGLE_CREDENTIALS_FILE"
  # Suppressing the output of the key to avoid showing it
  output_secret_name = "artifact-registry-sa-key"
  output_file        = "artifact-registry-sa-key.json"
}

  