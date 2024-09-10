
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS Trusted Advisor Check
resource "aws_trusted_advisor_check" "main" {
  category = "cost_optimization"
  check_id = "cost_optimization-check_for_unused_instances"

  # Optionally set a schedule for the check
  schedule {
    frequency = "weekly"
    # The day of the week to run the check (e.g., "MONDAY", "TUESDAY", etc.)
    day = "MONDAY"
  }
}

# Create an AWS Trusted Advisor Check Result
resource "aws_trusted_advisor_check_result" "main" {
  check_id = aws_trusted_advisor_check.main.check_id
  # Configure the severity level for the check result
  severity = "high"
  # The date and time to generate the result
  timestamp = "2024-03-10T12:00:00Z"
}

  