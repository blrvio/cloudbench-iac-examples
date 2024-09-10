
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Replace with your preferred region
}

# Create a Cloud Test Lab device
resource "google_cloud_test_lab_device" "default" {
  name   = "my-test-device"
  model  = "Nexus5"
  # Choose an appropriate device version
  version = "29"
  # Specify the location where the device will be created
  location = "us-central1"
}

# Create a Cloud Test Lab test matrix
resource "google_cloud_test_lab_test_matrix" "default" {
  app             = "path/to/your/app.apk"
  test_type       = "robo"
  # Choose an appropriate test type
  device_ids      = [google_cloud_test_lab_device.default.id]
  results_storage = "gs://your-bucket/results"
  # Specify the Google Cloud Storage bucket for storing test results
  timeout = "1h"
  # Set a timeout for the test execution
}

  