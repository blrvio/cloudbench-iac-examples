
    # Configure the IBM Cloud provider
provider "ibm-cloud" {
  region  = "us-south"
  api_key = "YOUR_IBM_API_KEY"
  # Optional: Set if using a specific IBM Cloud account
  # account_id = "YOUR_IBM_CLOUD_ACCOUNT_ID"
}

# Create a block storage volume
resource "ibm_vpc_block_storage" "main" {
  name = "my-block-storage-volume"
  # Select a zone for the volume
  zone = "us-south-1"
  # Specify the size of the volume
  size = 100 # in GB
  # Choose a volume type (e.g., 'standard', 'performance', 'iops')
  type = "standard"
  # Optionally, select an encryption key to encrypt the volume
  # encryption_key_id = "YOUR_ENCRYPTION_KEY_ID"
}

# Create a volume attachment
resource "ibm_vpc_block_storage_attachment" "main" {
  volume_id = ibm_vpc_block_storage.main.id
  instance_id = "YOUR_INSTANCE_ID"
}

# Note: Replace "YOUR_IBM_API_KEY", "YOUR_INSTANCE_ID", and other placeholders
# with your actual values.
  