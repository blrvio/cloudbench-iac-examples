
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an EventBridge bus
resource "aws_eventbridge_bus" "main" {
  name = "my-event-bus"
}

# Create an EventBridge rule
resource "aws_eventbridge_rule" "main" {
  name = "my-event-rule"
  # Event pattern to match events
  event_pattern = <<EOF
{
  "source": [
    "aws.ec2"
  ],
  "detail": {
    "instance-id": [
      "*"
    ]
  }
}
EOF
  # Target to invoke when the rule is matched
  targets {
    arn = aws_lambda_function.main.arn
  }
  # Optional: Enable the rule
  enabled = true
}

# Create a Lambda function
resource "aws_lambda_function" "main" {
  function_name = "my-lambda-function"
  runtime        = "nodejs16.x"
  handler        = "index.handler"
  role           = aws_iam_role.main.arn
  # Code to be uploaded to the function
  filename = "lambda_function.zip"
  # Optional: Set the memory and timeout values for the function
  memory_size   = 128
  timeout       = 30
}

# Create an IAM role for the Lambda function
resource "aws_iam_role" "main" {
  name = "my-lambda-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach the necessary permissions to the role
resource "aws_iam_role_policy" "main" {
  name = "my-lambda-policy"
  role = aws_iam_role.main.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:CreateLogGroup",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
EOF
}

# Create a CloudWatch event rule to trigger the Lambda function
resource "aws_cloudwatch_event_rule" "main" {
  name = "my-cloudwatch-event-rule"
  description = "Trigger Lambda function on EC2 instance state changes"
  # Event pattern to match events
  event_pattern = <<EOF
{
  "source": [
    "aws.ec2"
  ],
  "detail": {
    "instance-id": [
      "*"
    ]
  }
}
EOF
  # Target to invoke when the rule is matched
  targets {
    arn = aws_lambda_function.main.arn
  }
}

  