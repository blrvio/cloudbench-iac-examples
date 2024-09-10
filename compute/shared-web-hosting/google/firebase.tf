
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1" # Replace with your desired region
}

# Create a Firebase Hosting Site
resource "google_firebase_hosting_site" "main" {
  name    = "my-firebase-site"
  project = google_project.default.project_id
}

# Create a Firebase Hosting Release
resource "google_firebase_hosting_release" "main" {
  site_name = google_firebase_hosting_site.main.name
  project   = google_project.default.project_id
  config     = <<EOF
    {"public": "public/*", "ignore": ["**/.*", "node_modules/**", "firebase.json", "*.git", "*.md", "*.txt", "*.json"], "rewrites": [{"source": "**", "destination": "/index.html"}]}
EOF
}

# Create a Google Project (for authentication)
resource "google_project" "default" {
  project_id = "your-gcp-project-id"
  name        = "my-gcp-project"
  org_id       = "your-org-id" # Optional
}

# Create a Firebase App
resource "google_firebase_app" "default" {
  project    = google_project.default.project_id
  display_name = "my-firebase-app"
  # Optional, if you are using Firestore or Realtime Database
  # data_location = "us-central1"
}

# Create a Firebase Hosting File
resource "google_storage_bucket_object" "main" {
  name      = "index.html"
  source    = "index.html" # Path to your index.html file
  bucket    = google_storage_bucket.main.name
  cache_control = "max-age=3600"
}

# Create a Google Cloud Storage Bucket
resource "google_storage_bucket" "main" {
  name          = "my-firebase-site-bucket"
  location      = "US"
  force_destroy = true # Destroy the bucket even if it contains objects
  # Optional, if you want to enable versioning
  # versioning   = true
}

# Optionally, you can use a GCP Service Account for Authentication
# Create a Service Account
# resource "google_service_account" "default" {
#   account_id   = "your-service-account-id"
#   display_name = "my-service-account"
#   project      = google_project.default.project_id
# }
# 
# Create a Key for the Service Account
# resource "google_service_account_key" "default" {
#   service_account_id = google_service_account.default.account_id
#   project              = google_project.default.project_id
#   private_key_type    = "TYPE_GOOGLE_CREDENTIALS_FILE"
#   # You can control the expiration of the key here
#   # expire_time = "0001-01-01T00:00:00Z"
# }

# Set the path to your service account key
# export GOOGLE_APPLICATION_CREDENTIALS="path/to/your/service_account_key.json"

  