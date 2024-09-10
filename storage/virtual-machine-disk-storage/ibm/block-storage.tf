
    # Configure the IBM Cloud provider
provider "ibm" {
  ibmcloud_api_key = "YOUR_IBM_CLOUD_API_KEY" # Replace with your IBM Cloud API Key
  region        = "us-south" # Replace with your desired region
}

# Create a Block Storage volume
resource "ibm_block_storage_volume" "main" {
  name        = "my-block-storage-volume"
  size_gb     = 100 # Volume size in GB
  storage_type = "standard" # Storage type
  # Optional fields for advanced configuration
  # iops        = 1000 # I/O operations per second
  # throughput  = 100 # Throughput in MB/s
  # encryption  = true # Enable encryption
  # snapshot_id = "snapshot-id" # ID of a snapshot to use for creating the volume
}

# Create a Block Storage snapshot
resource "ibm_block_storage_snapshot" "main" {
  volume_id  = ibm_block_storage_volume.main.id # ID of the volume to snapshot
  name       = "my-snapshot"
  description = "My Block Storage snapshot"
}

# Attach a Block Storage volume to an instance
resource "ibm_instance_volume_attachment" "main" {
  instance_id  = "instance-id" # ID of the instance
  volume_id    = ibm_block_storage_volume.main.id # ID of the volume
  device_name = "/dev/sdb" # Device name
}

  