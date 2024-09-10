
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS Artifact repository
resource "aws_artifact_repository" "main" {
  name = "my-artifact-repository" # Name of your artifact repository
  # Optional configurations
  description = "My Artifact Repository"
  kms_key_id  = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012" # KMS key used to encrypt the repository
  # You can use the `aws_kms_key` resource to create a new KMS key
  # Example:
  # resource "aws_kms_key" "main" {
  #   description = "My KMS key for Artifact Repository"
  #   enable_key_rotation = true
  # }
}

# Create an AWS Artifact share
resource "aws_artifact_share" "main" {
  repository_id = aws_artifact_repository.main.id # ID of the artifact repository
  name         = "my-artifact-share" # Name of your artifact share
  # Optional configurations
  description = "My Artifact Share"
  # You can define the shared accounts using an AWS organization or by specifying the individual account IDs
  # For AWS organization, use the `organization` block
  organization {
    # Specify the organizational units (OUs) to share the artifact repository with
    organizational_units = ["OU-123456789012"]
  }
  # For individual accounts, use the `accounts` block
  # accounts {
  #   account_ids = ["123456789012", "987654321012"]
  # }
}

  