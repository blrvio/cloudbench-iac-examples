
    # Configure the Huawei Cloud provider
provider "huaweicloud" {
  region = "eu-west-1" # Replace with your desired region
}

# Create an OBS bucket
resource "huaweicloud_obs_bucket" "main" {
  name = "my-obs-bucket" # Name of your OBS bucket

  # Optional options
  acl = "private" # Set the access control list (ACL) for the bucket
  storage_class = "standard" # Set the storage class for the bucket
  # You can define tags for the bucket
  tags = {
    Name = "My OBS Bucket"
  }
}

# Create an OBS object
resource "huaweicloud_obs_object" "main" {
  bucket = huaweicloud_obs_bucket.main.name # Name of the OBS bucket
  key = "my-object.txt" # Name of the object
  source = "path/to/my-object.txt" # Path to the local file
}

  