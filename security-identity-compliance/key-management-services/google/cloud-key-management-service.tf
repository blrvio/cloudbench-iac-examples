
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a KMS CryptoKey
resource "google_kms_crypto_key" "default" {
  purpose       = "ENCRYPT_DECRYPT"
  crypto_key_ring_id = google_kms_crypto_key_ring.default.id
  version_template {
    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
  }
}

# Create a KMS KeyRing
resource "google_kms_crypto_key_ring" "default" {
  name    = "my-keyring"
  location = "global"
}

# Create a KMS KeyRing IAM Binding
resource "google_kms_crypto_key_iam_binding" "default" {
  role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = ["user:your-user@example.com"]
  crypto_key_id = google_kms_crypto_key.default.id
}
  