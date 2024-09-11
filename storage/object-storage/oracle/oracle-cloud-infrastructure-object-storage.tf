
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region     = "us-ashburn-1"
  tenancy    = "ocid1.tenancy.oc1..aaaaaaaaxxxxxx"
  user       = "ocid1.user.oc1..aaaaaaaayyyyyy"
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxx"
  # Use your real credentials
  # Make sure you have set up the OCI CLI and have credentials configured.
  # See: https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm
}

# Create an Object Storage Bucket
resource "oci_objectstorage_bucket" "example" {
  name       = "my-bucket"
  namespace  = "example"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaaaaaa"
  # Set an optional storage tier
  storage_tier = "Standard"
}

# Create an Object in the Bucket
resource "oci_objectstorage_object" "example" {
  name       = "my-object.txt"
  bucket     = oci_objectstorage_bucket.example.name
  namespace  = oci_objectstorage_bucket.example.namespace
  content    = "This is my object content."
  # Set an optional Content-Type
  content_type = "text/plain"
}

  