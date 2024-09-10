
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Snowball Job
resource "aws_snowball_job" "main" {
  address {
    line1 = "123 Main Street"
    line2 = "Suite 100"
    city  = "Anytown"
    state = "CA"
    zip   = "91234"
    country = "US"
  }
  description  = "My Snowball Job"
  job_type    = "IMPORT"
  notification {
    s3_event_notification {
      bucket_arn = "arn:aws:s3:::my-bucket"
      events     = ["Completed"]
    }
  }
  # Optionally specify the number of Snowballs to request
  number_of_jobs = 1
  # Specify the size of the Snowballs to request
  # Valid values are "T100" (100TB), "T80" (80TB), "T50" (50TB), "T40" (40TB), "T25" (25TB)
  # "T10" (10TB), "T8" (8TB), "T3" (3TB), or "T1" (1TB)
  # The default size is 80TB.
  # size = "T80"
  # Specify the resources to be transferred to or from the Snowball
  resources {
    # Specify the S3 bucket for the transfer
    # s3_bucket = "my-bucket"
    # Specify the S3 prefix for the transfer
    # s3_prefix = "my-prefix"
  }
  # Specify the type of Snowball to request
  # Valid values are "STANDARD", "EDGE", or "EDGE_CLUSTER"
  # The default type is STANDARD
  # type = "EDGE"
}

# Create a Snowball Job Manifest
resource "aws_snowball_job_manifest" "main" {
  job_id = aws_snowball_job.main.id
  # Specify the manifest file
  manifest_file_path = "path/to/manifest.txt"
}

# Create a Snowball Job Shipping Address
resource "aws_snowball_job_shipping_address" "main" {
  job_id = aws_snowball_job.main.id
  # Specify the shipping address
  shipping_address_id = "123456789012"
}

# Create a Snowball Job Shipping Instruction
resource "aws_snowball_job_shipping_instruction" "main" {
  job_id = aws_snowball_job.main.id
  # Specify the shipping instructions
  shipping_instructions = "Ship to the address specified in the shipping address"
}

# Create a Snowball Job Shipping Notification
resource "aws_snowball_job_shipping_notification" "main" {
  job_id = aws_snowball_job.main.id
  # Specify the shipping notification
  shipping_notification = "Notify me when the Snowball is shipped"
}

# Create a Snowball Job Tracking Number
resource "aws_snowball_job_tracking_number" "main" {
  job_id = aws_snowball_job.main.id
  # Specify the tracking number
  tracking_number = "123456789012"
}
  