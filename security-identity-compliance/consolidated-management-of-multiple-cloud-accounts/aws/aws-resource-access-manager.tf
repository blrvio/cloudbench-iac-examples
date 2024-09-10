
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Create a Resource Share
resource "aws_ram_resource_share" "main" {
  name = "my-resource-share"
  # Define the resources to share
  resource_arns = ["arn:aws:s3:::my-bucket", "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"]
  # Configure the sharing permissions
  allow_external_principals = false # Only allow sharing with accounts within the same organization
  # You can specify specific accounts to share with
  # principals = ["arn:aws:iam::123456789012:root"]
  # You can specify specific services to share with
  # services = ["ec2.amazonaws.com", "s3.amazonaws.com"]
  # Define the resource share permissions
  permissions = ["read", "write"]
  # You can specify specific actions to allow
  # actions = ["s3:GetObject", "s3:PutObject"]
  # Define the resource share tags
  tags = {
    Name = "My Resource Share"
  }
}

# Create a Resource Share Invitation
resource "aws_ram_resource_share_invitation" "main" {
  resource_share_arn = aws_ram_resource_share.main.arn
  # Define the account to invite
  recipient_account_id = "123456789012"
  # You can specify the resource share permissions for the invitation
  # permissions = ["read", "write"]
}

# Create a Resource Access Policy
resource "aws_ram_resource_access_policy" "main" {
  resource_share_arn = aws_ram_resource_share.main.arn
  # Define the policy document
  policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:root"
      },
      "Action": [
        "ram:GetResourceShare", 
        "ram:ListResources", 
        "ram:ListPermissions"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

  