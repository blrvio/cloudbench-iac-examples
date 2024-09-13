
      # Configure o provedor Firebase
provider "firebase" {
  project = "my-firebase-project"
}

# Crie um banco de dados Firestore
resource "firebase_firestore_database" "default" {
  name = "default"
}

# Crie um bucket do Cloud Storage
resource "google_storage_bucket" "default" {
  name = "my-firebase-bucket"
  location = "US"
  force_destroy = true
}

# Crie uma função Cloud Functions
resource "google_cloudfunctions2_function" "default" {
  name     = "my-function"
  runtime  = "nodejs16"
  entry_point = "helloWorld"
  source_archive_bucket = google_storage_bucket.default.name
  source_archive_object = "functions.zip"
  trigger_http = true
  region  = "us-central1"
}

# Crie um projeto do Firebase
resource "firebase_project" "default" {
  project_id = "my-firebase-project"
}

# Crie um aplicativo do Firebase
resource "firebase_app" "default" {
  project = firebase_project.default.project_id
  display_name = "my-app"
}

# Crie um usuário do Firebase
resource "firebase_user" "default" {
  email    = "user@example.com"
  password = "password"
  project = firebase_project.default.project_id
}

# Crie um documento no Firestore
resource "firebase_firestore_document" "default" {
  database = firebase_firestore_database.default.name
  collection = "users"
  document_id = "my-user"
  data = {
    name = "John Doe"
    age  = 30
  }
}
    