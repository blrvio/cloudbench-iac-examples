
      # Configure o provedor do Google Cloud
provider "google" {
  project = "project-id" # Substitua pelo ID do seu projeto
  region  = "us-central1" # Substitua pela região desejada
}

# Crie uma conta do Google Workspace
resource "google_workspace_account" "main" {
  display_name = "My Google Workspace Account"
  customer_type = "BUSINESS"
  edition = "BUSINESS_STANDARD"
  language = "en"
  timezone = "America/Los_Angeles"
}

# Crie um usuário do Google Workspace
resource "google_workspace_user" "admin" {
  account_id = google_workspace_account.main.account_id
  primary_email = "admin@example.com"
  password = "password"
  name = "Admin User"
  given_name = "Admin"
  family_name = "User"
}

# Crie um grupo do Google Workspace
resource "google_workspace_group" "admins" {
  account_id = google_workspace_account.main.account_id
  email = "admins@example.com"
  name = "Admins"
}

# Adicione o usuário ao grupo
resource "google_workspace_group_member" "admin_group" {
  group_key = google_workspace_group.admins.email
  member_key = google_workspace_user.admin.primary_email
}

# Crie uma unidade compartilhada no Google Drive
resource "google_drive_shared_drive" "shared_drive" {
  name = "Shared Drive"
  description = "Shared Drive for Team"
  team_drive_type = "TEAM_DRIVE"
}

# Configure a permissão de acesso ao compartilhamento
resource "google_drive_shared_drive_permission" "admin_access" {
  drive_id = google_drive_shared_drive.shared_drive.id
  role = "owner"
  type = "user"
  user_key = google_workspace_user.admin.primary_email
}
    