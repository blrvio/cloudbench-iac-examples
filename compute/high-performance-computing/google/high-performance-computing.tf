
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Replace with your desired region
}

# Create a Google Cloud Compute Engine instance
resource "google_compute_instance" "default" {
  name         = "my-hpc-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
    auto_delete  = true
  }
  network_interface {
    subnetwork = "projects/your-gcp-project-id/regions/us-central1/subnetworks/default"
  }
}

# Create a Google Cloud Storage bucket for data storage
resource "google_storage_bucket" "default" {
  name     = "my-hpc-data-bucket"
  location = "US"
  force_destroy = true
}

# Create a Google Cloud Storage object for HPC data
resource "google_storage_bucket_object" "default" {
  name     = "my-hpc-data.txt"
  bucket   = google_storage_bucket.default.name
  source   = "path/to/your/data"
}

# Create a Google Cloud Scheduler job to run an HPC application
resource "google_cloudfunctions2_function" "default" {
  name          = "my-hpc-scheduler"
  runtime       = "nodejs16"
  entry_point   = "scheduler"
  source_archive_bucket = google_storage_bucket.default.name
  source_archive_object  = "my-hpc-scheduler.zip"
  trigger_http = true
  timeout_seconds = 300
}

# Create a Google Cloud Pub/Sub topic to trigger the scheduler
resource "google_pubsub_topic" "default" {
  name = "my-hpc-topic"
}

# Create a Google Cloud Pub/Sub subscription to trigger the scheduler
resource "google_pubsub_subscription" "default" {
  name       = "my-hpc-subscription"
  topic      = google_pubsub_topic.default.name
  ack_deadline_seconds = 120
}

# Create a Google Cloud Eventarc trigger to fire the scheduler
resource "google_eventarc_trigger" "default" {
  name      = "my-hpc-trigger"
  event_type = "google.cloud.storage.object.finalized"
  event_filter {  
    attribute = "bucket"
    value     = google_storage_bucket.default.name
  }
  destination {  
    cloud_function {  
      function = google_cloudfunctions2_function.default.name
    }
  }
}

  