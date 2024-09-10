
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

# Create an AWS Config Recorder
resource "aws_config_recorder" "main" {
  name     = "my-config-recorder"                  # Name of the AWS Config Recorder
  role_arn = aws_iam_role.config_recorder_role.arn # ARN of the IAM role for the recorder
  recording_group {
    # Include all resource types in the recording group
    include_global_resource_types = true
    # Include all resource types in the recording group
    all_supported_resource_types = true
    # Configure the recording group to record all configuration changes
    recording_mode = "ALL"
  }
}

# Create an IAM role for the AWS Config Recorder
resource "aws_iam_role" "config_recorder_role" {
  name               = "config-recorder-role" # Name of the IAM role
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Create an IAM policy for the AWS Config Recorder
resource "aws_iam_policy" "config_recorder_policy" {
  name   = "config-recorder-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "config:PutConfigurationRecorder",
        "config:DescribeConfigurationRecorders",
        "config:DeleteConfigurationRecorder",
        "config:StartConfigurationRecorder",
        "config:StopConfigurationRecorder",
        "config:GetResourceConfigHistory",
        "config:DeliverConfigSnapshot",
        "config:PutDeliveryChannel",
        "config:DescribeDeliveryChannels",
        "config:DeleteDeliveryChannel",
        "config:DescribeConfigurationRecorderStatus"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach the policy to the IAM role
resource "aws_iam_role_policy_attachment" "config_recorder_policy_attachment" {
  role       = aws_iam_role.config_recorder_role.name
  policy_arn = aws_iam_policy.config_recorder_policy.arn
}

# Create an AWS Config Delivery Channel
resource "aws_config_delivery_channel" "main" {
  name           = "my-config-delivery-channel" # Name of the delivery channel
  s3_bucket_name = "my-config-bucket"           # Name of the S3 bucket for delivery
  # Configure the delivery channel to deliver configuration data to the S3 bucket
  config_snapshot_delivery_properties {
    delivery_frequency = "TwentyFourHours"
  }
}

  