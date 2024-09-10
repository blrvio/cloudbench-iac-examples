
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Transfer Appliance
resource "google_transfer_appliance" "default" {
  name     = "your-transfer-appliance-name"
  size     = "TRANSFER_APPPLIANCE_SIZE_100TB"
  location = "us-central1-a"
  # Add optional configurations here, like network settings, etc.
}

# Create a Transfer Appliance Instance
resource "google_transfer_appliance_instance" "default" {
  appliance = google_transfer_appliance.default.name
  name      = "your-transfer-appliance-instance-name"
  # Add optional configurations here, like network settings, etc.
}

# Create a Transfer Job
resource "google_transfer_job" "default" {
  name            = "your-transfer-job-name"
  description     = "Transfer job description"
  transfer_spec {
    # Configure your transfer settings
    aws_s3_data_source {
      bucket_name = "your-aws-s3-bucket-name"
      # Configure additional options
      # aws_access_key_id = "your-aws-access-key-id"
      # aws_secret_access_key = "your-aws-secret-access-key"
    }
    # Configure additional settings for other cloud providers
    # gcs_data_source {
    #   bucket_name = "your-gcp-storage-bucket-name"
    # }
  }
  transfer_appliance_instance = google_transfer_appliance_instance.default.name
  # Configure other options, like scheduling
  # schedule {
  #   start_time_of_day {
  #     hours = 12
  #     minutes = 0
  #   }
  #   recurrence_pattern = "R1/2017-04-08T00:00:00Z/P1D"
  # }
  # Add optional configurations for advanced settings
}

  