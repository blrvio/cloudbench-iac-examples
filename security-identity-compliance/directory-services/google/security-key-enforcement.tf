
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a Security Key Configuration
resource "google_kms_crypto_key" "default" {
  name     = "my-key"
  purpose  = "ENCRYPT_DECRYPT"
  key_ring = google_kms_key_ring.default.id
}

# Create a Key Ring
resource "google_kms_key_ring" "default" {
  name   = "my-key-ring"
  location = "us-central1"
}

# Create a Security Key Config
resource "google_kms_crypto_key" "security_key_config" {
  name     = "security-key-config"
  purpose  = "ENCRYPT_DECRYPT"
  key_ring = google_kms_key_ring.default.id
  # Configure security key protection
  protection_level = "HSM"
}

# Create a new IAM policy
resource "google_project_iam_member" "security_key_policy" {
  project = "your-project-id"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.default.email}"
}

# Create a Service Account
resource "google_service_account" "default" {
  account_id = "my-security-key-sa"
  display_name = "My Security Key Service Account"
}

# Create an IAM Service Account Key
resource "google_service_account_key" "default" {
  service_account_id = google_service_account.default.account_id
  # Suppress actual key creation as this is an example
  # You would actually generate the key in your terraform workflow
  # using `google_service_account_key.default.private_key`
  private_key = "your_key_here"
  project = "your-project-id"
  # This value is used for the filename of the key
  # Suppress actual key creation as this is an example
  # You would actually use `google_service_account_key.default.private_key`
  private_key_output_path = "${path.module}/sa_key.json"
}

  