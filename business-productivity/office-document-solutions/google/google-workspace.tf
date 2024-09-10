
    # Configure the Google provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a Google Workspace directory
resource "google_workspace_directory" "main" {
  customer_id = "your-customer-id"
  name        = "your-directory-name"
  # Specify the language used for the directory
  language_code = "en"
  # Specify the country code
  country_code = "US"
}

# Create a Google Workspace user
resource "google_workspace_user" "main" {
  directory_id = google_workspace_directory.main.id
  name          = "your-user-name"
  email         = "your-user-email@your-domain.com"
  password      = "your-password"
  # Specify the user's first name
  first_name = "Your"
  # Specify the user's last name
  last_name  = "User"
  # Specify the user's organizational unit
  organizational_unit = "your-organizational-unit"
}

# Create a Google Workspace group
resource "google_workspace_group" "main" {
  directory_id = google_workspace_directory.main.id
  name          = "your-group-name"
  email         = "your-group-email@your-domain.com"
  # Specify the group's description
  description = "Your group description"
}

# Add a user to a group
resource "google_workspace_group_member" "main" {
  group_id = google_workspace_group.main.id
  user_id  = google_workspace_user.main.id
}

  