
    # Configure the IBM Cloud provider
provider "ibm" {
  # Replace with your IBM Cloud account credentials
  api_key = "your_ibm_cloud_api_key"
  region = "us-south"
}

# Create an IBM Cloud Object Storage bucket
resource "ibm_cos_bucket" "main" {
  name = "my-cold-vault-bucket"
  # Define storage class
  storage_class = "cold_vault"
  # Optionally configure access control
  acl = "private"
}

# Create a file for the ColdVault
resource "ibm_cos_object" "main" {
  bucket = ibm_cos_bucket.main.name
  key    = "my-file.txt"
  # Add the content of your file here
  source = "your_file.txt"
}

  