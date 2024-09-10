
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS Snowball Job
resource "aws_snowball_job" "main" {
  description = "My Snowball Job"
  # Choose the type of job - Import or Export
  job_type = "IMPORT"
  # Set the number of Snowball devices
  number_of_devices = 1
  # Set the shipping address
  shipping_address {
    name         = "Your Name"
    company      = "Your Company"
    address1     = "Your Address"
    address2     = "Your Address (Optional)"
    city         = "Your City"
    state        = "Your State"
    zip          = "Your Zip Code"
    country      = "Your Country"
    phone_number = "Your Phone Number"
  }
  # Set the notification settings
  notification {
    # Set the SNS topic for notifications
    sns_topic_arn = "arn:aws:sns:us-east-1:123456789012:my-snowball-topic"
    # Set the S3 bucket for notifications
    s3_bucket = "my-snowball-bucket"
    # Set the S3 key prefix for notifications
    s3_key_prefix = "snowball-notifications"
  }
  # Set the resources for the job
  resources {
    # Set the S3 bucket and prefix for the import job
    s3_resources {
      bucket = "my-snowball-bucket"
      # Set the prefix for the import job
      key_prefix = "snowball-data"
    }
  }

  # Configure the resources to be imported
  # If you're importing data, provide the S3 bucket and key prefix
  # If you're exporting data, provide the S3 bucket and prefix
}

# Create an AWS Snowball Device
resource "aws_snowball_device" "main" {
  job_id = aws_snowball_job.main.id
  # The Snowball device will be created once the Snowball job is created
}

  