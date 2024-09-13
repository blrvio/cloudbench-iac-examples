
      # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a DevOps Guru configuration
resource "aws_devops_guru_configuration" "example" {
  name = "example"
  # ... other configuration options ...
}

# Create a DevOps Guru integration
resource "aws_devops_guru_integration" "example" {
  account_id = "123456789012" # Replace with your AWS account ID
  name        = "example"
  # ... other integration options ...
}

# Create a DevOps Guru notification channel
resource "aws_devops_guru_notification_channel" "example" {
  name = "example"
  type = "SNS"
  # ... other notification channel options ...
}
    