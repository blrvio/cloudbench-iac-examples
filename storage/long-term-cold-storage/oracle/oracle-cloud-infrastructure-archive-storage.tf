
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  # Replace with your tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..<your_tenancy_ocid>"
  # Replace with your user OCID
  user_ocid    = "ocid1.user.oc1..<your_user_ocid>"
  # Replace with your region
  region        = "us-ashburn-1"
  # Replace with your compartment OCID
  compartment_ocid = "ocid1.compartment.oc1..<your_compartment_ocid>"
}

# Create an archive storage
resource "oci_archive_storage" "main" {
  # Replace with your desired archive storage name
  display_name = "my-archive-storage"
  # Replace with your desired archive storage description
  description = "My archive storage description"
}

# Create an archive storage tier
resource "oci_archive_storage_tier" "main" {
  # Replace with your archive storage OCID
  archive_storage_id = oci_archive_storage.main.id
  # Replace with your desired archive storage tier name
  display_name = "my-archive-storage-tier"
  # Replace with your desired archive storage tier description
  description = "My archive storage tier description"
  # Replace with your desired archive storage tier storage size
  storage_size = 100
}

# Create an archive storage rule
resource "oci_archive_storage_rule" "main" {
  # Replace with your archive storage tier OCID
  archive_storage_tier_id = oci_archive_storage_tier.main.id
  # Replace with your desired archive storage rule name
  display_name = "my-archive-storage-rule"
  # Replace with your desired archive storage rule description
  description = "My archive storage rule description"
  # Replace with your desired archive storage rule storage size
  storage_size = 100
  # Replace with your desired archive storage rule storage size
  storage_size = 100
  # Replace with your desired archive storage rule storage size
  storage_size = 100
}

  