
    # Configure the Google Cloud Provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a service account
resource "google_service_account" "main" {
  account_id   = "your-service-account-id"
  display_name = "My Service Account"
  # Add a description to the service account
  description = "Service account for Terraform example"
  # Define a role for the service account
  role = "roles/iam.serviceAccountTokenCreator"
}

# Create a key for the service account
resource "google_service_account_key" "main" {
  service_account_id = google_service_account.main.account_id
  # Suppressing this string for brevity
  # You should replace it with your own string
  #  private_key_type = "TYPE_GOOGLE_CREDENTIALS_FILE"
  # Suppressing this string for brevity
  # You should replace it with your own string
  #  private_key_algorithm = "ALGORITHM_RSA_2048"
  # Suppressing this string for brevity
  # You should replace it with your own string
  #  private_key_data = "YOUR_PRIVATE_KEY_DATA"
}

  