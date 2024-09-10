
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
  api_key = "YOUR_IBM_CLOUD_API_KEY"
}

# Create a File Storage instance
resource "ibm_file_storage_instance" "main" {
  name         = "my-file-storage-instance"
  location      = "us-south"
  file_system_id = "YOUR_FILE_SYSTEM_ID"
  tier         = "standard"
  # Set the size of the storage instance in GB
  size = 100
}

# Attach a volume to the File Storage instance
resource "ibm_file_storage_volume_attachment" "main" {
  file_storage_instance_id = ibm_file_storage_instance.main.id
  volume_id               = "YOUR_VOLUME_ID"
}

# Create a volume
resource "ibm_file_storage_volume" "main" {
  name         = "my-file-storage-volume"
  location      = "us-south"
  file_system_id = "YOUR_FILE_SYSTEM_ID"
  size         = 100
  tier         = "standard"
}
  