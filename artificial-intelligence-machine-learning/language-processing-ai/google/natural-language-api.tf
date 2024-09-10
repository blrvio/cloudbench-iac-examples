
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Natural Language API Key
resource "google_api_key" "default" {
  name    = "natural-language-api-key"
  display_name = "Natural Language API Key"
  service = "language"
}

# Create a Natural Language API client
resource "google_service_account" "default" {
  account_id   = "natural-language-api-client"
  display_name = "Natural Language API Client"
  disabled     = false
}

# Grant the service account access to the Natural Language API
resource "google_project_iam_member" "default" {
  project = google_service_account.default.project
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:${google_service_account.default.email}"
}

# Create a Cloud KMS key to encrypt the API key
resource "google_kms_crypto_key" "default" {
  purpose = "ENCRYPT_DECRYPT"
  name    = "natural-language-api-key-kms-key"
}

# Encrypt the API key with the KMS key
resource "google_kms_crypto_key_iam_member" "default" {
  crypto_key_id = google_kms_crypto_key.default.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${google_service_account.default.email}"
}

# Configure the Natural Language API client to use the encrypted key
output "client_config" {
  value = "{
    "type": "service_account",
    "project_id": "${google_service_account.default.project}",
    "private_key_id": "${google_service_account.default.private_key_id}",
    "private_key": "${google_service_account.default.private_key}",
    "client_email": "${google_service_account.default.email}",
    "client_id": "${google_service_account.default.client_id}",
    "auth_uri": "${google_service_account.default.auth_uri}",
    "token_uri": "${google_service_account.default.token_uri}",
    "auth_provider_x509_cert_url": "${google_service_account.default.auth_provider_x509_cert_url}",
    "client_x509_cert_url": "${google_service_account.default.client_x509_cert_url}",
    "encryption_key": {
      "kms_key_name": "${google_kms_crypto_key.default.name}"
    }
  }"
}

  