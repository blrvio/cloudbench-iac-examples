
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Looker instance
resource "google_looker_instance" "main" {
  name         = "my-looker-instance"
  edition     = "enterprise"
  maintenance_window_day = "monday"
  maintenance_window_time = "03:00"
  # Suppress the creation of the first user
  initial_user_config {
    disabled = true
  }
  # Enable the Looker API
  api_enabled = true
  # Configure the Looker API endpoint
  api_endpoint = "https://api.looker.com"
  # Enable the Looker API proxy
  api_proxy_enabled = true
}

# Create a Looker group
resource "google_looker_group" "main" {
  name = "my-looker-group"
  # Suppress the creation of the first user
  initial_user_config {
    disabled = true
  }
}

# Create a Looker user
resource "google_looker_user" "main" {
  first_name  = "John"
  last_name   = "Doe"
  email        = "john.doe@example.com"
  group_ids   = [google_looker_group.main.id]
  # Suppress the creation of the first user
  initial_user_config {
    disabled = true
  }
  # Set the user password
  password = "password123"
  # Enable the Looker API for the user
  api_enabled = true
}

# Create a Looker content library
resource "google_looker_content_library" "main" {
  name         = "my-content-library"
  description = "This is my content library"
}

  