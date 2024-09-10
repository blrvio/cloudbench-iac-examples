
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS Chatbot
resource "aws_chatbot_bot" "main" {
  name = "my-chatbot" # Name of your AWS Chatbot
  # The Slack workspace ID
  slack_workspace_id = "TXXXXXXXX"
  # The Slack channel ID
  slack_channel_id = "CXXXXXXXX"

  # Set the chatbot's IAM role
  role_arn = aws_iam_role.chatbot_role.arn

  # Configure the chatbot's AWS Lambda function
  # Use the `aws_lambda_function` resource to create a Lambda function
  lambda_function_arn = aws_lambda_function.chatbot_function.arn

  # Optionally, configure the chatbot's conversation logs
  # The S3 bucket to store conversation logs
  s3_logs_bucket_name = "my-logs-bucket"
  # The prefix for conversation logs in the S3 bucket
  s3_logs_prefix = "chatbot-logs"

  # Configure the chatbot's integrations
  # Add integrations for services like AWS CloudWatch, Amazon SNS, etc.
  # See the AWS Chatbot documentation for available integrations.
}

# Create an IAM role for the chatbot
resource "aws_iam_role" "chatbot_role" {
  name = "chatbot_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "chatbot.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

# Create an IAM policy for the chatbot
resource "aws_iam_policy" "chatbot_policy" {
  name = "chatbot_policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "cloudwatch:PutMetricData"
        ],
        "Resource": "*"
      }
    ]
  })
}

# Attach the policy to the IAM role
resource "aws_iam_role_policy_attachment" "chatbot_policy_attachment" {
  role       = aws_iam_role.chatbot_role.name
  policy_arn = aws_iam_policy.chatbot_policy.arn
}

# Create an AWS Lambda function for the chatbot
resource "aws_lambda_function" "chatbot_function" {
  function_name = "chatbot_function"
  runtime        = "nodejs16.x"
  handler       = "index.handler"
  code          = filebase64("lambda_function.zip")
  memory_size     = 128
  timeout        = 30
  # Set the IAM role for the Lambda function
  role          = aws_iam_role.chatbot_role.arn

  # Configure the Lambda function's environment variables
  environment {
    variables = {
      # Replace with your actual environment variables
      "MY_ENV_VAR" = "my-value"
    }
  }
}

# Create an S3 bucket to store conversation logs
resource "aws_s3_bucket" "logs_bucket" {
  bucket = "my-logs-bucket"
  # Configure the S3 bucket's access control
  acl    = "private"
  # Configure the S3 bucket's versioning
  versioning {
    enabled = true
  }
  # Optionally, configure the S3 bucket's encryption
  # server_side_encryption_configuration {
  #   rule {
  #     apply_server_side_encryption_by_default {
  #       sse_algorithm = "AES256"
  #     }
  #   }
  # }
}

# Set the S3 bucket's policy to allow AWS Chatbot to write logs
resource "aws_s3_bucket_policy" "logs_bucket_policy" {
  bucket = aws_s3_bucket.logs_bucket.bucket
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "chatbot.amazonaws.com"
        },
        "Action": [
          "s3:PutObject"
        ],
        "Resource": "arn:aws:s3:::${aws_s3_bucket.logs_bucket.bucket}/*"
      }
    ]
  })
}

  