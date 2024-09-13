
      # Configure o provedor do Google Cloud
provider "google" {
  project = "gcp-project-id"
}

# Crie um repositório do Artifact Registry
resource "google_artifact_registry_repository" "default" {
  location   = "us-central1"
  project    = "gcp-project-id"
  repository = "my-repo"
  format     = "DOCKER"
}

# Crie uma chave de serviço para autenticação
resource "google_service_account" "default" {
  account_id   = "artifact-registry-sa"
  disabled     = false
  display_name = "Artifact Registry Service Account"
  project      = "gcp-project-id"
}

# Vincule a chave de serviço ao repositório
resource "google_artifact_registry_repository_iam_member" "default" {
  project    = "gcp-project-id"
  repository = "my-repo"
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.default.email}"
}
    