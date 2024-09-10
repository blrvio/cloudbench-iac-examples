
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  api_key = "YOUR_IBM_API_KEY"
  account_id = "YOUR_IBM_ACCOUNT_ID"
}

# Create a Hyper Protect Crypto Services instance
resource "ibm_hpc_crypto_service" "main" {
  name = "my-hpc-crypto-service"
  # Optional: Define the service plan
  plan = "basic"
  # Optional: Define the location of the service
  location = "us-south"
}

# Create a Hyper Protect Crypto Services key
resource "ibm_hpc_crypto_key" "main" {
  name        = "my-hpc-key"
  service_id = ibm_hpc_crypto_service.main.id
  # Optional: Define the key type
  key_type  = "AES256"
  # Optional: Define the key usage
  usage     = "ENCRYPT_DECRYPT"
}

# Create a Hyper Protect Crypto Services key ring
resource "ibm_hpc_crypto_key_ring" "main" {
  name        = "my-hpc-key-ring"
  service_id = ibm_hpc_crypto_service.main.id
}

# Associate the key to the key ring
resource "ibm_hpc_crypto_key_association" "main" {
  key_id    = ibm_hpc_crypto_key.main.id
  key_ring_id = ibm_hpc_crypto_key_ring.main.id
}
  