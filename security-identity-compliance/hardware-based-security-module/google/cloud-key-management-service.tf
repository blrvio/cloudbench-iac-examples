
    # Configure the Google Cloud provider
provider "google" {
  project = "gcp-project-id"
  region  = "us-central1"
}

# Create a KMS key ring
resource "google_kms_key_ring" "default" {
  location = "us-central1"
  name     = "my-key-ring"
}

# Create a KMS crypto key
resource "google_kms_crypto_key" "default" {
  key_ring = google_kms_key_ring.default.id
  purpose   = "ENCRYPT_DECRYPT"
  version_template {
    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
  }
}

  