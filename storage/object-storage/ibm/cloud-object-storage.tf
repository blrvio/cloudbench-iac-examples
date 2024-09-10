
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
}

# Create a Cloud Object Storage service instance
resource "ibm_cos_instance" "main" {
  name = "my-cos-instance"
  location = "us-south"
  resource_group_id = "your-resource-group-id"
  storage_class = "standard"
}

# Create a Cloud Object Storage bucket
resource "ibm_cos_bucket" "main" {
  name = "my-bucket"
  instance_id = ibm_cos_instance.main.id
}

# Create an object in the bucket
resource "ibm_cos_object" "main" {
  bucket_name = ibm_cos_bucket.main.name
  name = "my-object.txt"
  content = "Hello, world!"
}
  