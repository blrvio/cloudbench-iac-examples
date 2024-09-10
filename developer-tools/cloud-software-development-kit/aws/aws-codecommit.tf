
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS CodeCommit Repository
resource "aws_codecommit_repository" "main" {
  repository_name = "my-codecommit-repo" # Name of your CodeCommit repository

  # Optional settings
  #  The encryption configuration for the repository.
  encryption_configuration {
    enabled = true # Enable encryption at rest
    kms_key_id = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012" # KMS key ID for encryption
  }

  #  The repository's default branch name.
  default_branch_name = "main"

  #  A list of repository triggers.
  trigger {
    name = "MyTrigger"
    branches = ["main"]
    events = ["all"]
    #  Configuration for invoking a webhook URL when an event occurs in the repository.
    destination_arn = "arn:aws:lambda:us-east-1:123456789012:function:my-lambda-function"
    #  The custom data that is included in the webhook payload.
    custom_data = "{"key1": "value1", "key2": "value2"}"
  }
}

# Create an AWS CodeCommit Trigger
resource "aws_codecommit_trigger" "main" {
  repository_name = aws_codecommit_repository.main.repository_name
  name              = "MyTrigger"
  branches          = ["main"]
  events            = ["all"]
  # Configuration for invoking a webhook URL when an event occurs in the repository.
  destination_arn = "arn:aws:lambda:us-east-1:123456789012:function:my-lambda-function"
  # The custom data that is included in the webhook payload.
  custom_data = "{"key1": "value1", "key2": "value2"}"
}

  