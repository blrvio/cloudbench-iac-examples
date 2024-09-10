
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a new Eventarc Trigger
resource "google_eventarc_trigger" "default" {
  name     = "my-trigger"
  event_type = "google.cloud.storage.object.v1.finalized"
  project  = "your-gcp-project-id"

  destination {
    cloud_function {
      function_region = "us-central1"
      function_name  = "my-function"
    }
  }
}

# Create a Cloud Function
resource "google_cloudfunctions2_function" "default" {
  name     = "my-function"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = "your-cloud-storage-bucket-name"
  source_archive_object = "my-function.zip"
  trigger_http  = true
  region    = "us-central1"
  project  = "your-gcp-project-id"
}

  