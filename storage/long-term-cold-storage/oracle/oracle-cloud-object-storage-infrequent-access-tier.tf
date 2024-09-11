
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  # Replace with your tenancy OCID
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your user OCID
  user_ocid = "ocid1.user.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  # Replace with your region
  region = "us-ashburn-1"
  # Replace with your private key file path
  private_key_file = "./path/to/private_key_file"
  # Replace with your fingerprint
  fingerprint = "12:34:56:78:90:ab:cd:ef:01:23:45:67:89:0a:bc:de"
}

# Create a bucket in Oracle Cloud Object Storage
resource "oci_objectstorage_bucket" "example" {
  namespace   = "example"
  name        = "my-bucket"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  storage_tier  = "INFREQUENT_ACCESS"
}

# Create a namespace in Oracle Cloud Object Storage
resource "oci_objectstorage_namespace" "example" {
  name = "example"
  # Replace with your compartment OCID
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}

  