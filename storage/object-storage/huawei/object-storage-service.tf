
    # Configure the Huawei Cloud Provider
provider "huaweicloud" {
  region = "cn-north-1" # Replace with your desired region
}

# Create an OBS bucket
resource "huaweicloud_obs_bucket" "main" {
  name = "my-obs-bucket" # Replace with your desired bucket name
  # Optional configurations
  acl        = "private" # Default access control list
  storage_class = "standard" # Storage class for the bucket
  # Define tags for the bucket
  tags = {
    Name = "My OBS Bucket"
  }
}

# Create an OBS object
resource "huaweicloud_obs_object" "main" {
  bucket = huaweicloud_obs_bucket.main.name # Bucket name
  key    = "my-object.txt" # Object key
  source = "path/to/your/file" # Path to the source file
}

  