
    # Configure the Google Cloud provider
provider "google" {
  project = "gcp-project-id"
  # Optional: Set a region for resource creation
  region  = "us-central1"
}

# Create a new organization
resource "google_organization" "main" {
  display_name = "My Organization"
  # Optional: Set a folder for the organization
  folder_id    = "folders/1234567890"
  # Optional: Disable organization policies
  disable_org_policies = false
}

# Create a new project
resource "google_project" "main" {
  name = "my-project"
  # Optional: Set an organization for the project
  org_id = google_organization.main.id
  # Optional: Set a project number
  project_number = 1234567890
}

# Create a new folder
resource "google_folder" "main" {
  display_name = "My Folder"
  # Optional: Set a parent folder for the folder
  parent = "folders/1234567890"
}

# Create a new IAM policy
resource "google_project_iam_member" "main" {
  project = "my-project"
  role    = "roles/owner"
  member  = "user:my-user@example.com"
}

  