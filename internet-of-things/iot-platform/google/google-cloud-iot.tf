
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1" # Choose your region
}

# Create a Cloud IoT Core Registry
resource "google_iot_registry" "main" {
  name     = "my-registry"
  region   = "us-central1" # Choose your region
  event_notification_config {
    pubsub_topic = "projects/your-project-id/topics/my-topic"
  }
}

# Create a Cloud IoT Core Device
resource "google_iot_device" "main" {
  registry_id = google_iot_registry.main.id
  name        = "my-device"
}

# Create a Google Cloud Pub/Sub topic to receive device events
resource "google_pubsub_topic" "main" {
  name = "my-topic"
}

# Create a Google Cloud Function to process device events
resource "google_cloudfunctions2_function" "main" {
  name     = "my-function"
  runtime  = "nodejs16"
  entry_point = "helloHTTP"
  trigger_http = true
  source_archive_bucket = "your-bucket-name"
  source_archive_object = "your-function-code.zip"
  region  = "us-central1" # Choose your region
}

  