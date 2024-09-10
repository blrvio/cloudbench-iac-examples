
    # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a WorkDocs user
resource "aws_workdocs_user" "main" {
  email_address = "john.doe@example.com"
  # Optional fields
  # user_name     = "johndoe"
  # given_name    = "John"
  # surname       = "Doe"
  # role          = "USER"
  # storage_rule  = "STANDARD"
  # organization_id = aws_workdocs_organization.main.id
}

# Create a WorkDocs organization
resource "aws_workdocs_organization" "main" {
  # Optional fields
  # directory_id = "your_directory_id"
}

# Create a WorkDocs folder
resource "aws_workdocs_folder" "main" {
  name     = "My Folder"
  parent_id = "root"
  # Optional fields
  # storage_rule = "STANDARD"
  # organization_id = aws_workdocs_organization.main.id
  # user_id       = aws_workdocs_user.main.id
}

  