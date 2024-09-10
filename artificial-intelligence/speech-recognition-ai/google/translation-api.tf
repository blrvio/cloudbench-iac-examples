
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1" # Replace with your desired region
}

# Create a service account for the Translation API
resource "google_service_account" "translation_api" {
  account_id   = "translation-api"
  display_name = "Translation API Service Account"
  disabled     = false

  # Define the roles for the service account
  role = ["roles/translate.translator"]
}

# Create a key for the service account
resource "google_service_account_key" "translation_api" {
  service_account_id = google_service_account.translation_api.account_id
  # Suppress long key content for this example.
  #  key_algorithm = "RSA_2048"
  #  key_type = "TYPE_SERVICE_ACCOUNT"
}

# Define the Translation API project
resource "google_project_service" "translation_api" {
  service  = "translate.googleapis.com"
  disabled = false
  project  = "your-project-id"
}

  