
# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS NICE DCV Session
resource "aws_dcv_session" "main" {
  name = "my-dcv-session" # Name of the NICE DCV session
  # Select the NICE DCV endpoint to use
  endpoint_id = aws_dcv_endpoint.main.id
  # Specify the type of NICE DCV session to create
  session_type = "single" # Options: single, multi
  # Optional settings for the NICE DCV session
  # e.g., session_duration, session_timeout, etc.
  # ...
}

# Create an AWS NICE DCV Endpoint
resource "aws_dcv_endpoint" "main" {
  name = "my-dcv-endpoint" # Name of the NICE DCV endpoint
  # Select the NICE DCV port range to use
  port_range = "10000-20000"
  # Optional settings for the NICE DCV endpoint
  # e.g., security_group_ids, subnet_ids, etc.
  # ...
}

  