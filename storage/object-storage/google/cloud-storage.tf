
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Google Cloud Storage Bucket
resource "google_storage_bucket" "main" {
  name          = "my-storage-bucket"
  force_destroy = true
  location      = "US"
  uniform_bucket_level_access = true
  storage_class = "STANDARD"
  project       = "your-gcp-project-id"
}

# Create a Google Cloud Storage Bucket Object
resource "google_storage_bucket_object" "main" {
  bucket = google_storage_bucket.main.name
  name   = "my-object.txt"
  source = "path/to/local/file"
}

  