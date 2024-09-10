
# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an S3 bucket
resource "aws_s3_bucket" "main" {
  bucket = "my-s3-bucket" # Name of your S3 bucket
  # Define the bucket's access control list (ACL)
  acl = "private" # Set the default ACL to "private"
  # Configure versioning for the bucket
  versioning {
    enabled = true
  }
  # Set the bucket's tags
  tags = {
    Name = "My S3 Bucket"
  }
}

# Create an S3 bucket policy
resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowPublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::my-s3-bucket/*"
      ]
    }
  ]
}
EOF
}

# Create an S3 object
resource "aws_s3_object" "main" {
  bucket = aws_s3_bucket.main.id
  key    = "my-object.txt"
  source = "my-object.txt" # Path to the file you want to upload
  # Set the object's Content-Type
  content_type = "text/plain"
}

# Create an S3 object version
resource "aws_s3_object_version" "main" {
  bucket = aws_s3_bucket.main.id
  key    = "my-object.txt"
  source = "my-object.txt" # Path to the file you want to upload
  # Define the object's version ID
  version_id = "my-object.txt-version-id"
}

  