
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region = "us-ashburn-1"
  # Add your credentials here
}

# Create a storage gateway
resource "oci_storage_gateway" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz7y724q7"
  display_name  = "my-storage-gateway"
  # Optional: Configure the storage gateway network
  network_config {
    subnet_id  = "ocid1.subnet.oc1..aaaaaaaaz7y724q7"
    security_list_ids = ["ocid1.securitylist.oc1..aaaaaaaaz7y724q7"]
  }
  # Optional: Configure the storage gateway storage
  storage_config {
    storage_type = "file"
  }
  # Optional: Configure the storage gateway file system
  file_system_config {
    file_system_name = "my-file-system"
    # Optional: Configure the storage gateway file system mount target
    mount_target {
      mount_target_name = "my-mount-target"
      # Optional: Configure the storage gateway file system mount target subnet
      subnet_id = "ocid1.subnet.oc1..aaaaaaaaz7y724q7"
    }
  }
}

# Create a storage gateway file system
resource "oci_storage_gateway_file_system" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz7y724q7"
  storage_gateway_id = oci_storage_gateway.main.id
  display_name = "my-file-system"
}

# Create a storage gateway mount target
resource "oci_storage_gateway_mount_target" "main" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz7y724q7"
  storage_gateway_id = oci_storage_gateway.main.id
  file_system_id = oci_storage_gateway_file_system.main.id
  display_name = "my-mount-target"
  # Optional: Configure the storage gateway mount target subnet
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaz7y724q7"
}

  