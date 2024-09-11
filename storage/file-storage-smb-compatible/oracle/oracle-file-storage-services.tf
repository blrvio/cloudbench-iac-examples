
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  # Provide your OCI tenancy ID
tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Provide your OCI user OCID
  user_ocid  = "ocid1.user.oc1..aaaaaaaaxxxxxxxxxxxxxx"
  # Provide your OCI region
  region = "us-ashburn-1"
  # Provide your OCI compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx"
}

# Create a File Storage Namespace
resource "oci_file_storage_namespace" "main" {
  name  = "my-file-storage-namespace"
  # Provide a description for the namespace
  description = "My file storage namespace"
}

# Create a File Storage System
resource "oci_file_storage_system" "main" {
  # Provide the file storage namespace ID
  namespace_id = oci_file_storage_namespace.main.id
  name          = "my-file-storage-system"
  # Provide a description for the system
  description = "My file storage system"
  # Select the storage tier
  storage_tier = "STANDARD"
}

# Create a File Storage Mount Target
resource "oci_file_storage_mount_target" "main" {
  # Provide the file storage system ID
  system_id = oci_file_storage_system.main.id
  name      = "my-file-storage-mount-target"
  # Select the subnet ID for the mount target
  subnet_id = "ocid1.subnet.oc1..aaaaaaaaxxxxxxxxxxxxxx"
}

  