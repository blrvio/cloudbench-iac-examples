
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an IAM Role for your AWS Tools
resource "aws_iam_role" "tools_role" {
  name = "tools-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

# Attach the necessary policies to the IAM role
resource "aws_iam_role_policy_attachment" "tools_policy" {
  role       = aws_iam_role.tools_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

# Create an IAM User for your AWS Tools
resource "aws_iam_user" "tools_user" {
  name = "tools-user"
}

# Create an access key for the IAM user
resource "aws_iam_access_key" "tools_key" {
  user = aws_iam_user.tools_user.name
}

# Create an IAM Policy for your AWS Tools
resource "aws_iam_policy" "tools_policy" {
  name = "tools-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:*",
          "s3:*"
        ],
        "Resource" : "*"
      }
    ]
  })
}

# Attach the IAM Policy to the IAM Role
resource "aws_iam_role_policy_attachment" "tools_policy_attachment" {
  role       = aws_iam_role.tools_role.id
  policy_arn = aws_iam_policy.tools_policy.arn
}

# Output the access key ID and secret access key for your AWS Tools
output "access_key_id" {
  value = aws_iam_access_key.tools_key.id
}
output "secret_access_key" {
  value     = aws_iam_access_key.tools_key.secret
  sensitive = true
}

  