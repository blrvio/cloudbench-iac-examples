
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Migration Hub Home Region
resource "aws_migrationhub_home_region_control" "main" {
  home_region = "us-east-1" # The region you want to set as the Migration Hub home region
}

# Create a Migration Hub Application Discovery Service (ADS) Configuration
resource "aws_migrationhub_application_discovery_service_configuration" "main" {
  account_id = aws_caller_identity.current.account_id
  # Optional: If you want to set a specific name for the ADS configuration
  # name       = "my-ads-config"
}

# Create a Migration Hub Migration Task
resource "aws_migrationhub_migration_task" "main" {
  migration_task_name = "my-migration-task"
  # Optional: If you want to use a specific AWS account ID
  # account_id = aws_caller_identity.current.account_id
}

# Create a Migration Hub Progress Update Stream
resource "aws_migrationhub_progress_update_stream" "main" {
  progress_update_stream_name = "my-progress-update-stream"
  # Optional: If you want to use a specific AWS account ID
  # account_id = aws_caller_identity.current.account_id
}

# Create a Migration Hub Server Migration Service (SMS) Configuration
resource "aws_migrationhub_server_migration_service_configuration" "main" {
  account_id = aws_caller_identity.current.account_id
  # Optional: If you want to set a specific name for the SMS configuration
  # name       = "my-sms-config"
}

# Create a Migration Hub Service
resource "aws_migrationhub_service" "main" {
  account_id = aws_caller_identity.current.account_id
}

# Create a Migration Hub Tag
resource "aws_migrationhub_tag" "main" {
  migration_task_name = aws_migrationhub_migration_task.main.migration_task_name
  tag_key             = "Environment"
  tag_value           = "Production"
}

# Create a Migration Hub User Account
resource "aws_migrationhub_user_account" "main" {
  account_id = aws_caller_identity.current.account_id
  # Optional: If you want to set a specific name for the user account
  # name       = "my-user-account"
}

# Create a Migration Hub User Account Association
resource "aws_migrationhub_user_account_association" "main" {
  account_id          = aws_caller_identity.current.account_id
  migration_task_name = aws_migrationhub_migration_task.main.migration_task_name
}

# Create a Migration Hub User Account Association with a Tag
resource "aws_migrationhub_user_account_association" "main" {
  account_id          = aws_caller_identity.current.account_id
  migration_task_name = aws_migrationhub_migration_task.main.migration_task_name
  tags = {
    Environment = "Production"
  }
}
  