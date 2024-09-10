
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS Snowcone Device
resource "aws_snowcone_device" "main" {
  name = "my-snowcone-device" # Name of your Snowcone device

  # Optional parameters:
  # location = "us-east-1" # Region where the device will be shipped
  # shipping_address {
  #   name = "Your Name"
  #   address_line1 = "Your Address"
  #   city = "Your City"
  #   state = "Your State"
  #   postal_code = "Your Zip Code"
  #   country = "Your Country"
  #   phone_number = "Your Phone Number"
  # }
}

# Create a Snowcone Job
resource "aws_snowcone_job" "main" {
  device_id = aws_snowcone_device.main.id # ID of your Snowcone device
  name = "my-snowcone-job" # Name of your Snowcone job
  # Description of the job
  description = "My Snowcone Job"

  # Optional parameters:
  # target_s3_bucket = "my-s3-bucket" # S3 bucket where data will be uploaded
  # kms_key_arn = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012" # KMS key for encrypting data

  # Define the data transfer configuration
  data_transfer_config {
    # Specify the type of data transfer
    type = "IMPORT" #  "IMPORT" or "EXPORT"

    # Define the source or destination
    s3_config {
      #  bucket = "my-s3-bucket" #  S3 bucket name
      #  prefix = "my-prefix" # S3 prefix
    }
  }
}

  