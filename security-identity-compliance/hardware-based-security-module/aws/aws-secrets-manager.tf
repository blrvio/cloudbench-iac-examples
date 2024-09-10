
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Secrets Manager Secret
resource "aws_secretsmanager_secret" "main" {
  name = "my-secret-name" # Name of your secret
  description = "My secret description" # Optional description
  # Optional: You can specify the KMS key to encrypt the secret data
  # kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"

  # Define the secret value
  secret_string = "my-secret-value" # Replace with your actual secret value
}

# Create a Secret Version for the secret
resource "aws_secretsmanager_secret_version" "main" {
  secret_id = aws_secretsmanager_secret.main.id # Secret ID
  secret_string = "my-secret-value-version-2" # Replace with your actual secret value

  # Specify a version stage for the secret version. Can be one of "AWSCURRENT", "AWSPREVIOUS", or "AWSPENDING"
  version_stages = ["AWSCURRENT"]
}

# Grant access to a role to retrieve the secret
resource "aws_secretsmanager_secret_policy" "main" {
  secret_id = aws_secretsmanager_secret.main.id # Secret ID

  # Define the policy for the secret
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:role/my-role" # Replace with the ARN of your role
      },
      "Action": [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ],
      "Resource": "arn:aws:secretsmanager:us-east-1:123456789012:secret:my-secret-name:latest" # Replace with your secret ARN
    }
  ]
}
EOF
}

  