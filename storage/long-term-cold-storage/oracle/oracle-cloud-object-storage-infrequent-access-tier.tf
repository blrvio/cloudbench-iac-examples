
    # Configure the Oracle Cloud provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your actual OCI configuration
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaw776i65765775546464464464"
  user_ocid = "ocid1.user.oc1..aaaaaaaaw776i65765775546464464464"
  fingerprint = ""
  # Add your private key to the "~/.oci/config" file or specify the location here
  # private_key_file = "~/.oci/oci_api_key.pem"
}

# Create a bucket
resource "oci_objectstorage_bucket" "main" {
  name = "my-bucket"
  namespace = "my-namespace"
  # Optional: Specify the storage tier
  # storage_tier = "INFREQUENT_ACCESS"
}

# Upload an object
resource "oci_objectstorage_object" "main" {
  bucket = oci_objectstorage_bucket.main.name
  namespace = oci_objectstorage_bucket.main.namespace
  name = "my-object.txt"
  source = "path/to/local/file"
}

  