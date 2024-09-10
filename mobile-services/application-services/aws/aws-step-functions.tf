
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Define the State Machine
resource "aws_sfn_state_machine" "main" {
  name = "my-state-machine" # Name of your state machine
  role_arn = aws_iam_role.main.arn # ARN of the IAM role used for the state machine
  definition = <<EOF
{
  "StartAt": "HelloWorld",
  "States": {
    "HelloWorld": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:us-east-1:123456789012:function:hello-world",
      "End": true
    }
  }
}
EOF
}

# Define the IAM Role for the State Machine
resource "aws_iam_role" "main" {
  name = "my-state-machine-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "states.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach the necessary permissions to the IAM role
resource "aws_iam_role_policy" "main" {
  name = "my-state-machine-policy"
  role = aws_iam_role.main.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "lambda:InvokeFunction"
      ],
      "Resource": "arn:aws:lambda:us-east-1:123456789012:function:hello-world"
    }
  ]
}
EOF
}

  