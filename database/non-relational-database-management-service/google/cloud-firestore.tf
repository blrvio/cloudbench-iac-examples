
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id" # Substitua pelo ID do seu projeto
}

# Crie um banco de dados do Firestore
resource "google_firestore_database" "main" {
  name    = "default"
  project = google_project.default.project_id
}

# Crie uma coleção no Firestore
resource "google_firestore_document" "users" {
  collection  = "users"
  document_id = "user1"
  project     = google_project.default.project_id
  database    = google_firestore_database.main.name

  fields = {
    "name" = "John Doe"
    "email" = "john.doe@example.com"
  }
}

# Crie um índice no Firestore
resource "google_firestore_index" "users_by_email" {
  collection_group = "users"
  fields           = [{"field_path": "email", "order": "ASCENDING"}]
  project          = google_project.default.project_id
  database         = google_firestore_database.main.name
}
    