
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Lambda Function
resource "aws_lambda_function" "main" {
  function_name = "my-lambda-function"         # Name of your Lambda function
  runtime       = "nodejs16.x"                 # Runtime environment for the function
  handler       = "index.handler"              # Entry point for the function
  role          = aws_iam_role.lambda_role.arn # IAM role for the function
  memory_size   = 128                          # Memory allocated to the function (MB)
  timeout       = 30                           # Timeout for the function (seconds)

  # Define the code for the function
  # You can either provide the code directly in the code attribute, or
  # reference a file in the local file system.
  # In this example, we are using a file from the local file system.
  filename = "lambda_function.zip" # Path to your Lambda function code
  # Optional: You can configure the function's environment variables here
  environment {
    variables = {
      MY_ENV_VAR = "my-env-value"
    }
  }
}

# Create an IAM role for the Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  # Assign the necessary permissions to the role
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

# Attach the necessary permissions to the IAM role
resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda_policy"
  role   = aws_iam_role.lambda_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream",
        "logs:CreateLogGroup",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}
EOF
}

  