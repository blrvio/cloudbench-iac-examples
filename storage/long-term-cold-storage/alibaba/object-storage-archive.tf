
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  # Replace with your Alibaba Cloud region
  region = "cn-hangzhou"
}

# Create a bucket
resource "alicloud_oss_bucket" "main" {
  bucket = "my-oss-bucket" # Replace with your desired bucket name
  location = "cn-hangzhou" # Replace with your desired region
}

# Create a bucket policy
resource "alicloud_oss_bucket_policy" "main" {
  bucket    = alicloud_oss_bucket.main.bucket
  policy    = <<POLICY
{
  "Version": "1.0",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "oss:GetObject"
      ],
      "Resource": [
        "acs:oss:*:*:my-oss-bucket/*"
      ]
    }
  ]
}
POLICY
}

# Upload an object to the bucket
resource "alicloud_oss_object" "main" {
  bucket = alicloud_oss_bucket.main.bucket
  key    = "my-object.txt"
  source = "my-object.txt" # Replace with the local path to your object
}
  