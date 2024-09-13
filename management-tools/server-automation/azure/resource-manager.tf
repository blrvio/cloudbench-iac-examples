
      # Configure the Google Cloud provider
provider "google" {
  project = "gcp-project-id"
}

# Create a new organization
resource "google_organization" "my_organization" {
  display_name  = "My Organization"
  parent        = "organizations/0"
  folder_creation_policy = "ALLOW"
}

# Create a new folder
resource "google_folder" "my_folder" {
  display_name = "My Folder"
  parent = google_organization.my_organization.name
  organization = google_organization.my_organization.name
}

# Create a new project
resource "google_project" "my_project" {
  name  = "my-project"
  project_id = "my-project-id"
  organization = google_organization.my_organization.name
  folder = google_folder.my_folder.name

  billing_account = "billing-account-id"
  labels = {
    environment = "production"
  }
}

# Create a new service account
resource "google_service_account" "my_service_account" {
  account_id   = "my-service-account"
  display_name = "My Service Account"
  disabled = false
  project = "my-project-id"
}

# Create a new IAM role
resource "google_project_iam_member" "my_iam_role" {
  project = "my-project-id"
  role = "roles/owner"
  member = "serviceAccount:${google_service_account.my_service_account.email}"
}
    