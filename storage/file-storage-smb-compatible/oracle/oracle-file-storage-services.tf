
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region  = "us-ashburn-1"
  tenancy = "ocid1.tenancy.oc1..."
  user     = "ocid1.user.oc1..."
  key_file = "~/.oci/config"
}

# Create a File Storage Service
resource "oci_file_storage_file_system" "main" {
  compartment_id = "ocid1.compartment.oc1..."
  display_name  = "my-file-system"
  
  # Set the storage tier
  storage_tier = "STANDARD_IA"
}

# Create a mount target for the file system
resource "oci_file_storage_mount_target" "main" {
  compartment_id = "ocid1.compartment.oc1..."
  display_name  = "my-mount-target"
  file_system_id = oci_file_storage_file_system.main.id
  
  # Set the subnet to use for the mount target
  subnet_id = "ocid1.subnet.oc1..."
}

  