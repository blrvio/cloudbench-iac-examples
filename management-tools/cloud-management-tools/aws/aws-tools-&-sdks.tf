
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an IAM user
resource "aws_iam_user" "main" {
  name = "my-terraform-user"
}

# Create an IAM access key for the user
resource "aws_iam_access_key" "main" {
  user = aws_iam_user.main.name
}

# Create an IAM policy
resource "aws_iam_policy" "main" {
  name   = "my-terraform-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "s3:GetObject"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach the policy to the IAM user
resource "aws_iam_user_policy_attachment" "main" {
  user       = aws_iam_user.main.name
  policy_arn = aws_iam_policy.main.arn
}

# Output the access key and secret key
output "access_key_id" {
  value = aws_iam_access_key.main.id
}

output "secret_access_key" {
  value = aws_iam_access_key.main.secret
}

# This is a basic example of using AWS Tools and SDKs with Terraform.
# You can use this code to create IAM users and policies for your Terraform
# infrastructure, as well as to grant access to other AWS services. 

  