
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a Cloud Function
resource "google_cloudfunctions2_function" "main" {
  name     = "my-cloud-function"
  runtime  = "nodejs16"
  entry_point = "helloWorld"
  source_archive_bucket = "your-bucket-name"
  source_archive_object = "your-function-code.zip"

  # Trigger the function on HTTP requests
  trigger_http {
    # Optional: Specify the URL path
    # url_path = "my-path"
  }

  # Optional: Set environment variables
  # environment {
  #   variables = {
  #     MY_VAR = "my-value"
  #   }
  # }
}

# Create a bucket for function code
resource "google_storage_bucket" "main" {
  name    = "your-bucket-name"
  location = "US"
  force_destroy = true
}
  