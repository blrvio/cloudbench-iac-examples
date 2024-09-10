
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a MediaStore Container
resource "aws_mediastore_container" "main" {
  name = "my-mediastore-container" # Name of your MediaStore Container

  # Optional settings
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:root"
      },
      "Action": [
        "mediastore:PutObject",
        "mediastore:GetObject",
        "mediastore:DeleteObject",
        "mediastore:ListObjects"
      ],
      "Resource": "arn:aws:mediastore:us-east-1:123456789012:container/my-mediastore-container/*"
    }
  ]
}
EOF
}

# Create a MediaStore Datastore
resource "aws_mediastore_datastore" "main" {
  name = "my-mediastore-datastore" # Name of your MediaStore Datastore
  container_name = aws_mediastore_container.main.name # Name of the MediaStore Container

  # Optional settings
  access_type = "public" # "public" or "private"
  # Create a MediaStore Datastore with the specific access type
}

# Configure an AWS KMS key for encrypting data at rest
resource "aws_kms_key" "main" {
  description = "KMS key for encrypting MediaStore data"

  # Choose the desired key policy
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:root"
      },
      "Action": [
        "kms:DescribeKey",
        "kms:EnableKeyRotation",
        "kms:DisableKeyRotation",
        "kms:GetKeyPolicy",
        "kms:GetKeyRotationStatus",
        "kms:ListKeyPolicies",
        "kms:ListAliases",
        "kms:DescribeKey",
        "kms:GetPublicKey"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:role/mediastore-role"
      },
      "Action": [
        "kms:Decrypt",
        "kms:Encrypt",
        "kms:GenerateDataKey",
        "kms:GenerateDataKeyWithoutPlaintext",
        "kms:ReEncryptFrom",
        "kms:ReEncryptTo",
        "kms:DescribeKey",
        "kms:GetPublicKey"
      ],
      "Resource": "*"
    }
  ]
}
EOF

  # Optional: Specify a key policy to restrict access to the key
  # policy = jsonencode({
  #   Version = "2012-10-17"
  #   Statement = [
  #     {
  #       Effect = "Allow"
  #       Principal = {
  #         AWS = "arn:aws:iam::123456789012:role/mediastore-role"
  #       }
  #       Action = [
  #         "kms:DescribeKey"
  #         "kms:EnableKeyRotation"
  #         "kms:DisableKeyRotation"
  #         "kms:GetKeyPolicy"
  #         "kms:GetKeyRotationStatus"
  #         "kms:ListKeyPolicies"
  #         "kms:ListAliases"
  #         "kms:DescribeKey"
  #         "kms:GetPublicKey"
  #         "kms:Decrypt"
  #         "kms:Encrypt"
  #         "kms:GenerateDataKey"
  #         "kms:GenerateDataKeyWithoutPlaintext"
  #         "kms:ReEncryptFrom"
  #         "kms:ReEncryptTo"
  #       ]
  #       Resource = "*"
  #     }
  #   ]
  # })
}

# Create an IAM role for MediaStore access
resource "aws_iam_role" "mediastore_role" {
  name = "mediastore-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "mediastore.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach the KMS key policy to the MediaStore role
resource "aws_iam_role_policy_attachment" "mediastore_kms_policy" {
  role = aws_iam_role.mediastore_role.name
  policy_arn = aws_kms_key.main.arn
}

# Create an IAM policy for MediaStore access
resource "aws_iam_policy" "mediastore_policy" {
  name = "mediastore-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "mediastore:PutObject",
        "mediastore:GetObject",
        "mediastore:DeleteObject",
        "mediastore:ListObjects",
        "mediastore:GetContainerPolicy"
      ],
      "Resource": "arn:aws:mediastore:us-east-1:123456789012:container/my-mediastore-container/*"
    }
  ]
}
EOF
}

# Attach the MediaStore policy to the MediaStore role
resource "aws_iam_role_policy_attachment" "mediastore_policy_attachment" {
  role = aws_iam_role.mediastore_role.name
  policy_arn = aws_iam_policy.mediastore_policy.arn
}

  