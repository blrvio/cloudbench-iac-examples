
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

# Create an AWS IoT Button
resource "aws_iot_button" "main" {
  button_name = "my-iot-button"  # Name of the AWS IoT Button
  # Optional arguments
  #  iot_thing_name = "my-thing-name"  # Name of the IoT thing to which the button is associated
  #  iot_thing_type = "button"  # Type of the IoT thing
  #  iot_thing_attributes = {  # Attributes of the IoT thing
  #    "attribute1" = "value1"
  #    "attribute2" = "value2"
  #  }
  #  iot_thing_shadow_properties = {  # Shadow properties of the IoT thing
  #    "desired" = {
  #      "property1" = "value1"
  #      "property2" = "value2"
  #    }
  #  }
}

# Create an AWS Lambda Function to handle button presses
resource "aws_lambda_function" "main" {
  function_name = "my-button-handler"
  runtime       = "nodejs16.x"
  handler       = "index.handler"
  role          = aws_iam_role.lambda_role.arn
  memory_size    = 128
  timeout       = 30
  # Add your Lambda code here
  code = <<EOF
// Export a handler that can be invoked by the AWS IoT Button
exports.handler = (event, context, callback) => {
  console.log(JSON.stringify(event, null, 2));
  // Your code to handle button presses goes here
  // For example, you can send a notification, update a database, etc.
  callback(null, 'Button pressed successfully!');
};
EOF
}

# Create an IAM role for the Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"
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

# Attach a policy to the IAM role to allow the Lambda function to access AWS IoT
resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda-policy"
  role   = aws_iam_role.lambda_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iot:Publish",
        "iot:Receive",
        "iot:Subscribe"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Associate the Lambda function with the AWS IoT Button
resource "aws_iot_button_thing_action" "main" {
  button_name = aws_iot_button.main.button_name
  iot_action {
    lambda {
      function_arn = aws_lambda_function.main.arn
    }
  }
}

  