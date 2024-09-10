
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

# Create a Macie Custom Data Identifier
resource "aws_macie2_custom_data_identifier" "example" {
  name             = "MyCustomDataIdentifier"
  description      = "This is my custom data identifier for sensitive information"
  regex            = "(\d{3}-\d{3}-\d{4})"
  ignore_case      = true
  finding_type    = "CUSTOM_DATA_IDENTIFIER_FINDING"
  detections_status = "ACTIVE"
}

# Create a Macie Member Account
resource "aws_macie2_member_account" "example" {
  account_id = "123456789012" # Replace with the account ID of the member account
  # Optional settings for the member account
  # invitation_disabled = false
  # invitation_message = "Welcome to Macie!"
}

# Create a Macie Classification Job
resource "aws_macie2_classification_job" "example" {
  name    = "MyClassificationJob"
  # Specify the S3 bucket to classify
  s3_job {
    bucket_name = "my-bucket"
  }
  # Define the custom data identifiers to use
  custom_data_identifiers = [aws_macie2_custom_data_identifier.example.id]
}

  