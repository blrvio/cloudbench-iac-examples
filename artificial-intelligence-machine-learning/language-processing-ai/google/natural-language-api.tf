
      # Configure o provedor Google Cloud
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

resource "google_project_service" "natural_language" {
  service = "language"
  disable_on_destroy = false
}

resource "google_service_account" "sa" {
  account_id   = "your-service-account-id"
  display_name = "Natural Language API Service Account"
}

# A lista de permissões necessárias para a API pode variar de acordo com o uso
# Consulte a documentação oficial para obter a lista completa.
resource "google_project_iam_member" "sa_reader" {
  project = google_project_service.natural_language.project
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_service_account_key" "sa_key" {
  service_account_id = google_service_account.sa.account_id
  project = google_project_service.natural_language.project
}

# Implemente a análise de sentimento
resource "google_natural_language_sentiment" "sentiment" {
  content = "This is a great product!"
  type = "PLAIN_TEXT"
}
    