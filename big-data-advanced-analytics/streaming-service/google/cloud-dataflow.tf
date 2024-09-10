
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Cloud Dataflow Job
resource "google_dataflow_job" "main" {
  name     = "my-dataflow-job"
  location = google_dataflow_job.main.location
  job_type = "BATCH"

  # Specify the Dataflow pipeline
  pipeline {
    # Replace with your actual pipeline definition
    pipeline_options {
      # Specify the template path for your pipeline
      "template_location" = "gs://your-bucket/dataflow-template.json"

      # Add other pipeline options
      # "worker_machine_type" = "n1-standard-1"
      # "max_num_workers" = "10"
    }
  }
}

# Create a Cloud Storage Bucket for storing Dataflow data
resource "google_storage_bucket" "main" {
  name     = "my-dataflow-bucket"
  location = "US"
  force_destroy = true
  # Add other bucket configuration options
  # uniform_bucket_level_access = true
  # versioning = true
}

  