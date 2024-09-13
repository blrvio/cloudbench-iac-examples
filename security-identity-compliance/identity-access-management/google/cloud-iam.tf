
      # Configure o provedor do Google Cloud
provider "google" {
  project = "your-project-id"
}

# Crie um novo usuário do IAM
resource "google_iam_service_account" "my_user" {
  account_id = "my-user"
  display_name = "My User"
}

# Crie uma nova chave de serviço
resource "google_iam_service_account_key" "my_key" {
  service_account_id = google_iam_service_account.my_user.account_id
  private_key_type = "TYPE_GOOGLE_CREDENTIALS_FILE"
  # Supressão de atributos longos de chave
}

# Crie uma nova função do IAM
resource "google_iam_policy" "my_policy" {
  binding {
    role = "roles/owner"
    members = ["serviceAccount:my-user@your-project-id.iam.gserviceaccount.com"]
  }
}

    