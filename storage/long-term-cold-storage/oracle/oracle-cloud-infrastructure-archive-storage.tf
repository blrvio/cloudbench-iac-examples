
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region = "us-ashburn-1"
  # Add your Oracle Cloud Infrastructure credentials here
  # You can also use environment variables
  # See: https://www.terraform.io/docs/providers/oci/index.html
}

# Create an Archive Storage Bucket
resource "oci_objectstorage_bucket" "archive_bucket" {
  namespace_name = "your-namespace"
  bucket_name    = "your-archive-bucket"
  storage_tier   = "ARCHIVE"
}

# Create an Archive Storage Object
resource "oci_objectstorage_object" "archive_object" {
  namespace_name = oci_objectstorage_bucket.archive_bucket.namespace_name
  bucket_name    = oci_objectstorage_bucket.archive_bucket.bucket_name
  object_name    = "your-archive-object"
  # The content of the object
  content        = "This is an archive object"
}

  