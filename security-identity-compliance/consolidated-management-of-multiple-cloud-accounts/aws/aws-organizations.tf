
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS Organization
resource "aws_organizations_organization" "main" {
  feature_set = "ALL"
  # Optional: You can specify a different root account ID if needed
  # root_id = "123456789012"
}

# Create an Organizational Unit (OU)
resource "aws_organizations_organizational_unit" "main" {
  name        = "my-ou"
  parent_id   = aws_organizations_organization.main.id
}

# Create a policy for the OU
resource "aws_organizations_policy" "main" {
  name     = "my-policy"
  content  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:root"
      },
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeVpcs",
        "ec2:DescribeSecurityGroups"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  type      = "SERVICE_CONTROL_POLICY"
}

# Attach the policy to the OU
resource "aws_organizations_policy_attachment" "main" {
  policy_id = aws_organizations_policy.main.id
  target_id = aws_organizations_organizational_unit.main.id
}

# Create an account in the OU
resource "aws_organizations_account" "main" {
  email           = "my-account@example.com"
  name           = "my-account"
  parent_id      = aws_organizations_organizational_unit.main.id
  # Optional: You can configure the account's settings
  # settings { # See the AWS Organizations API documentation for available settings
  #   # ...
  # }
}

# Create a service control policy (SCP) for the root account
resource "aws_organizations_policy" "root_scp" {
  name     = "my-root-scp"
  content  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "ec2:CreateVpc",
        "ec2:DeleteVpc"
      ],
      "Resource": "*"
    }
  ]
}
EOF
  type      = "SERVICE_CONTROL_POLICY"
}

# Attach the SCP to the root account
resource "aws_organizations_policy_attachment" "root" {
  policy_id = aws_organizations_policy.root_scp.id
  target_id = aws_organizations_organization.main.root_id
}

# Create a delegated administrator for the OU
resource "aws_organizations_delegated_administrator" "main" {
  service_principal = "iam.amazonaws.com"
  target_id         = aws_organizations_organizational_unit.main.id
}

# Create a hand-off account
resource "aws_organizations_account" "handoff" {
  email           = "handoff-account@example.com"
  name           = "handoff-account"
  parent_id      = aws_organizations_organizational_unit.main.id
  # Configure the account for handoff
  settings { # See the AWS Organizations API documentation for available settings
    # ...
  }
}

# Note: You can also manage accounts and policies using the AWS Organizations API or the AWS Management Console.
  