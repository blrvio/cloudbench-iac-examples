
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region = "us-ashburn-1"
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  user_ocid = "ocid1.user.oc1..aaaaaaaaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  fingerprint = "xxxxxxxxxxxxxxxxxxxxxxxx"
  private_key_path = "~/.oci/oci_api_key.pem"
}

# Create an Object Storage Bucket
resource "oci_objectstorage_bucket" "example" {
  namespace = "example-namespace"
  name     = "example-bucket"

  # Optional configurations
  # storage_tier = "STANDARD"
  # public_access_type = "ObjectRead"
}

# Create an Object in the Bucket
resource "oci_objectstorage_object" "example" {
  namespace = "example-namespace"
  bucket    = oci_objectstorage_bucket.example.name
  name     = "example-object"

  # Define the object content
  content  = "This is an example object"
}

  