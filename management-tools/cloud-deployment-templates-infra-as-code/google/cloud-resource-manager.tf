
      # Configure o provedor do Google Cloud
provider "google" {
  project = "project-id" # Substitua pelo ID do seu projeto
}

# Crie uma nova organização
resource "google_organization" "main_organization" {
  display_name  = "My Organization"
  parent        = "organizations/0"
  billing_account = "billing-account-id" # Substitua pelo ID da sua conta de faturamento
}

# Crie um novo projeto
resource "google_project" "main_project" {
  name          = "my-project"
  organization  = google_organization.main_organization.id
  project_id    = "my-project-id"
}

# Adicione uma IAM policy para o projeto
resource "google_project_iam_binding" "project_owner" {
  project = google_project.main_project.project_id
  role    = "roles/owner"
  members = ["user:user@example.com"] # Substitua pelo e-mail do usuário
}

# Crie uma nova pasta
resource "google_folder" "main_folder" {
  display_name = "My Folder"
  parent        = "organizations/0"
  organization  = google_organization.main_organization.id
}

# Mova o projeto para a pasta
resource "google_project_service_identity" "main_project_identity" {
  project     = google_project.main_project.project_id
  service_account_id = "project-sa"
  disable_on_destroy = true
}

resource "google_project_iam_binding" "project_service_account_owner" {
  project = google_project.main_project.project_id
  role    = "roles/owner"
  members = ["serviceAccount:project-sa@gcp-sa-project-id.iam.gserviceaccount.com"]
}
    