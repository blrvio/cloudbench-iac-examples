
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region  = "cn-hangzhou"
  # Add your credentials here
  access_key = "YOUR_ACCESS_KEY_ID"
  secret_key = "YOUR_ACCESS_KEY_SECRET"
}

# Create a bucket in Object Storage Service (OSS)
resource "alicloud_oss_bucket" "main" {
  bucket = "my-oss-bucket" # Replace with your bucket name
  location = "cn-hangzhou" # Replace with your desired region

  # Optional settings
  storage_class = "Standard"
  acl           = "private"
  force_destroy  = true
}

# Upload an object to the bucket
resource "alicloud_oss_object" "main" {
  bucket = alicloud_oss_bucket.main.bucket
  key    = "my-object.txt" # Replace with your object name
  source = "local-file.txt" # Replace with your local file path
  # Optional settings
  # content_type = "text/plain"
  # cache_control = "max-age=3600"
}

  