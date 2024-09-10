
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a WorkSpaces directory
resource "aws_workspaces_directory" "main" {
  # Use the same directory ID if using an existing directory.
  # Otherwise, a new directory will be created.
  directory_id  = "d-1234567890" # Replace with your directory ID
  # Specify a new directory if not using an existing one
  # alias  = "example-workspace-directory"
  #  enable_sso  = true
  #  customer_user_name  = "example"
  #  registration_code  = "example"
  #  tags = {
  #    Name = "example"
  #  }
  #  user_access_logging_enabled  = false
  #  volume_encryption_enabled  = true
  #  directory_type = "SIMPLE_AD"
}

# Create a WorkSpaces bundle
resource "aws_workspaces_bundle" "main" {
  # Use the same bundle ID if using an existing bundle
  # Otherwise, a new bundle will be created
  bundle_id  = "b-1234567890" # Replace with your bundle ID
  #  name  = "example-bundle"
  #  compute_type = "VALUE"
  #  user_volume_size = 100
  #  root_volume_size = 200
  #  running_mode = "AUTO_STOP"
  #  user_volume_throughput = 100
  #  user_volume_type = "STANDARD"
  #  tags = {
  #    Name = "example"
  #  }
}

# Create a WorkSpaces workspace
resource "aws_workspaces_workspace" "main" {
  # Use the same workspace ID if using an existing workspace
  # Otherwise, a new workspace will be created
  workspace_id  = "ws-1234567890" # Replace with your workspace ID
  #  bundle_id = aws_workspaces_bundle.main.bundle_id
  #  directory_id = aws_workspaces_directory.main.directory_id
  #  user_name = "example"
  #  workspace_properties {
  #    running_mode = "AUTO_STOP"
  #  }
  #  tags = {
  #    Name = "example"
  #  }
}

# Create a WorkSpaces user
resource "aws_workspaces_user" "main" {
  # Use the same user ID if using an existing user
  # Otherwise, a new user will be created
  user_id = "user-1234567890" # Replace with your user ID
  #  directory_id = aws_workspaces_directory.main.directory_id
  #  user_name = "example"
  #  user_type = "STANDARD"
  #  tags = {
  #    Name = "example"
  #  }
}
  