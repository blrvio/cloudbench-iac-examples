
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS X-Ray Sampling Rule
resource "aws_xray_sampling_rule" "main" {
  name = "my-sampling-rule"
  rule = <<EOF
# The rule is a JSON document
{
  "name": "my-sampling-rule",
  "type": "fixed_rate",
  "fixed_rate": 0.01,
  "service": "my-service-name",
  "version": 1
}
EOF
}

# Create an AWS X-Ray Group
resource "aws_xray_group" "main" {
  name = "my-xray-group"
  # Create a sampling rule for the group
  sampling_rule_ids = [aws_xray_sampling_rule.main.id]
  # Optionally define the tags for the group
  tags = {
    Name = "My X-Ray Group"
  }
}

# Create an AWS X-Ray Encryption Config
resource "aws_xray_encryption_config" "main" {
  # Define the KMS key ARN to use for encryption
  kms_key_arn = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
}

# Create an AWS X-Ray Logging Config
resource "aws_xray_logging_config" "main" {
  # Define the logging configuration for X-Ray
  logging_config {
    # Define the type of logging to use (either "DATA_ONLY" or "ALL")
    type = "ALL"
    # Define the log group name
    log_group_name = "my-log-group"
    # Define the log stream name
    log_stream_name = "my-log-stream"
  }
}

# Create an AWS X-Ray Resource
resource "aws_xray_resource" "main" {
  # Define the resource name
  resource_name = "my-resource"
  # Define the resource type
  resource_type = "EC2"
}

  