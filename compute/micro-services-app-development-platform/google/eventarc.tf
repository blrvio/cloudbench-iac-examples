
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create an Eventarc Trigger
resource "google_eventarc_trigger" "default" {
  name     = "my-trigger"
  event_filter {
    event_type = "google.cloud.audit.log.v1.write"
  }
  destination {
    cloud_function {
      function = "projects/your-project-id/locations/us-central1/functions/my-function"
    }
  }
}

# Create a Cloud Function
resource "google_cloudfunctions2_function" "default" {
  name     = "my-function"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  source_archive_bucket = "your-bucket-name"
  source_archive_object = "my-function.zip"
}

# Create a Storage Bucket (if needed)
resource "google_storage_bucket" "default" {
  name          = "your-bucket-name"
  force_destroy = true
  location = "US"
  uniform_bucket_level_access = true
}
  