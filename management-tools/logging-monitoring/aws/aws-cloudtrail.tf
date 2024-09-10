
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a CloudTrail Trail
resource "aws_cloudtrail" "main" {
  name = "my-cloudtrail-trail" # Name of the CloudTrail trail
  # Specify the S3 bucket where CloudTrail logs will be stored
  s3_bucket_name = "my-cloudtrail-bucket"
  # Optionally, define a prefix for the log files
  s3_key_prefix = "cloudtrail-logs"
  # Configure the trail to log all events
  include_global_service_events = true
  # Optionally, specify a KMS key to encrypt the logs
  # kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"

  # Define the events to be logged
  event_selector {
    read_write_type = ["All"]
    # Optionally, specify specific data events
    # data_resource_types = ["S3:Object", "DynamoDB:Table"]
  }
}

# Create an S3 Bucket for CloudTrail logs
resource "aws_s3_bucket" "main" {
  bucket = "my-cloudtrail-bucket"
  acl    = "private"

  # Optionally, define a server-side encryption configuration
  # server_side_encryption_configuration {
  #   rule {
  #     apply_server_side_encryption_by_default {
  #       sse_algorithm = "AES256"
  #     }
  #   }
  # }
}

# Create an IAM role for CloudTrail
resource "aws_iam_role" "main" {
  name = "cloudtrail-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudtrail.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

# Attach the IAM policy to the CloudTrail role
resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.id
  policy_arn = "arn:aws:iam::aws:policy/AWSManagedPolicies/service-role/AWS_CloudTrail_ReadOnly_Access"
}

  