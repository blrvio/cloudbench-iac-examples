
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Firestore database
resource "google_firestore_database" "default" {
  name = "my-firestore-database"
}

# Create a Firestore document
resource "google_firestore_document" "my-document" {
  database = google_firestore_database.default.name
  collection = "my-collection"
  name       = "my-document"
  fields = {
    "name"    = "My Document"
    "age"    = 25
    "active" = true
  }
}

# Create a Firestore index
resource "google_firestore_index" "index_on_name" {
  database  = google_firestore_database.default.name
  collection = "my-collection"
  fields = [
    {
      field_path = "name"
      order       = "ASCENDING"
    }
  ]
}

  