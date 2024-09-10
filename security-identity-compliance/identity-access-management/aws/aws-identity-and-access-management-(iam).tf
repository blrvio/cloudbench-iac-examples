
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an IAM User
resource "aws_iam_user" "main" {
  name = "my-iam-user" # Name of the IAM user
}

# Create an IAM Policy
resource "aws_iam_policy" "main" {
  name = "my-iam-policy" # Name of the IAM policy
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:*"
        ],
        "Resource": [
          "arn:aws:s3:::my-s3-bucket/*"
        ]
      }
    ]
  })
}

# Attach the IAM Policy to the IAM User
resource "aws_iam_user_policy_attachment" "main" {
  user      = aws_iam_user.main.name
  policy_arn = aws_iam_policy.main.arn
}

# Create an IAM Role
resource "aws_iam_role" "main" {
  name = "my-iam-role" # Name of the IAM role
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

# Attach the IAM Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn
}

  