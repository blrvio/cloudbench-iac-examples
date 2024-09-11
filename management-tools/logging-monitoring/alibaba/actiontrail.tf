
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region  = "cn-hangzhou"  # Replace with your desired region
  # Credentials can be set via environment variables or the alicloud provider configuration
}

# Create an ActionTrail
resource "alicloud_actiontrail" "main" {
  name          = "my-actiontrail"
  # Configure the ActionTrail to store events in a specific OSS bucket
  oss_bucket_name = "my-oss-bucket"  # Replace with your OSS bucket name
  # Specify the ActionTrail's storage duration
  event_retention_days = 30
  # Set the ActionTrail's status
  status           = "Active"
  # Define the events to record
  events  = ["oss:PutObject","oss:GetObject"]
}

# Create an OSS bucket to store the ActionTrail events
resource "alicloud_oss_bucket" "main" {
  bucket  = "my-oss-bucket"
  # Optional: Set the bucket's location
  location = "cn-hangzhou"
}

  