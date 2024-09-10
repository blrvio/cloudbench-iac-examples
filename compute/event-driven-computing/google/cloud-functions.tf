
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Cloud Function
resource "google_cloudfunctions2_function" "main" {
  name     = "my-cloud-function"
  runtime  = "nodejs16"
  entry_point = "helloWorld"
  source_archive_bucket = "your-bucket-name"
  source_archive_object = "my-function.zip"
  trigger_http = true
}

# Create a Cloud Storage bucket to store the function code
resource "google_storage_bucket" "main" {
  name          = "your-bucket-name"
  force_destroy = true
  location      = "US"
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
}

# Create a service account
resource "google_service_account" "main" {
  account_id = "my-service-account"
  display_name = "My Cloud Function Service Account"
  disabled = false
}

# Grant the service account the Cloud Functions Invoker role
resource "google_project_iam_member" "main" {
  project = "your-gcp-project-id"
  role    = "roles/cloudfunctions.invoker"
  member  = "serviceAccount:${google_service_account.main.email}"
}

  