
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Storage Transfer Job
resource "google_storage_transfer_job" "default" {
  description = "Transfer data from Google Cloud Storage to Amazon S3"
  # Set the source and destination for the data transfer
  transfer_spec {
    # Set the source Google Cloud Storage bucket
    source_bucket_name = "source-bucket-name"
    # Set the destination Amazon S3 bucket
    aws_s3_data_sink {
      bucket_name = "destination-bucket-name"
      # Configure Amazon S3 access credentials
      aws_access_key_id = "your-aws-access-key-id"
      secret_access_key = "your-aws-secret-access-key"
    }
  }
  # Set the schedule for the data transfer
  schedule {
    # Set the schedule to run daily
    schedule_start_time { day_of_week = "MONDAY" }
  }
  # Configure the transfer job
  transfer_job_config {
    # Set the maximum number of objects to be transferred per transfer
    object_conditions {
      max_objects_per_transfer = 100
    }
  }
}

  