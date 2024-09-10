
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Google Cloud Storage Bucket
resource "google_storage_bucket" "main" {
  name     = "my-storage-bucket"
  location = "US"
  force_destroy = true

  # Define Storage Class
  storage_class = "STANDARD"

  # Set Uniform Bucket-Level Access
  uniform_bucket_level_access = true

  # Configure Access Control
  access_control {
    role    = "OWNER"
    entity  = "user-your-gcp-account@example.com"
  }
}

# Create a Storage Object
resource "google_storage_bucket_object" "main" {
  bucket = google_storage_bucket.main.name
  name   = "my-object.txt"
  source = "path/to/local/file.txt"
}

  