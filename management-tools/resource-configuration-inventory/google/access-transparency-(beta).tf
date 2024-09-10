
    # Configure the Google Cloud provider
provider "google" {
  project = "my-project-id" # Replace with your GCP project ID
  region = "us-central1" # Replace with your desired region
}

# Enable Access Transparency for a specific project
resource "google_access_transparency_access_level" "main" {
  name = "my-access-level"
  project = "my-project-id" # Replace with your GCP project ID
  description = "Access level for my-project-id"
  # Configure the access level settings
  access_level_config {
    basic {
      # Define access level constraints
      # Refer to documentation for specific constraint types and settings
      # example:  
      # required_authorization {
      #   access_condition {
      #     access_condition_name = "access-condition-name"
      #   }
      # }
    }
  }
}

# Create an Access Transparency service account
resource "google_service_account" "main" {
  account_id = "my-service-account"
  project = "my-project-id" # Replace with your GCP project ID
  display_name = "My Service Account"
  # Configure access level settings
  access_level_config {
    access_level_key {
      access_level_name = google_access_transparency_access_level.main.name
    }
  }
}

# Create a service account key for the Access Transparency service account
resource "google_service_account_key" "main" {
  service_account_id = google_service_account.main.account_id
  project = "my-project-id" # Replace with your GCP project ID
  key_algorithm = "RSA_2048" # Choose the desired key algorithm
  # Do not store the private key in plain text in your Terraform code
  # You can save the private key locally and manage it securely.
}

  