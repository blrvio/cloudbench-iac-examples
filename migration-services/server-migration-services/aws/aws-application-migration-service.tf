
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an Application Migration Service (AWS MIGRATION HUB) Home Region
resource "aws_migrationhub_home_region_control" "main" {
  home_region = "us-east-1" # Your desired Home Region
}

# Create an AWS MIGRATION HUB Configuration
resource "aws_migrationhub_configuration" "main" {
  home_region = aws_migrationhub_home_region_control.main.home_region
}

# Create an AWS MIGRATION HUB Server Migration Service (SMS) Configuration
resource "aws_migrationhub_sms_configuration" "main" {
  server_migration_service_configuration {
    # Set the S3 bucket for storing server migration service data
    s3_bucket = "your-s3-bucket-name" # Replace with your S3 bucket name
    # Optionally set the role for the S3 bucket
    s3_bucket_role_arn = "arn:aws:iam::123456789012:role/your-s3-bucket-role"
    # Optionally set the region of the S3 bucket
    s3_bucket_region = "us-east-1"
  }
}

# Create an AWS MIGRATION HUB Application Discovery Service (ADS) Configuration
resource "aws_migrationhub_ads_configuration" "main" {
  application_discovery_service_configuration {
    # Set the S3 bucket for storing application discovery service data
    s3_bucket = "your-s3-bucket-name" # Replace with your S3 bucket name
    # Optionally set the role for the S3 bucket
    s3_bucket_role_arn = "arn:aws:iam::123456789012:role/your-s3-bucket-role"
    # Optionally set the region of the S3 bucket
    s3_bucket_region = "us-east-1"
  }
}

# Create an AWS MIGRATION HUB Migration Task
resource "aws_migrationhub_migration_task" "main" {
  name       = "my-migration-task" # Replace with your desired task name
  description = "My migration task description"
  # Optionally set the status of the task
  status = "COMPLETED"
  # Set the configuration ID for the task
  configuration_id = aws_migrationhub_configuration.main.configuration_id
}

  