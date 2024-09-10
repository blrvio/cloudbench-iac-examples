
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a DataSync Agent
resource "aws_datasync_agent" "main" {
  activation_key = "your-activation-key"
  name            = "my-datasync-agent"
  # Optional: Assign tags to the DataSync agent
  tags = {
    Name = "My DataSync Agent"
  }
}

# Create a DataSync Location (S3)
resource "aws_datasync_location_s3" "main" {
  subdirectory = "my-data-sync-bucket/data"
  bucket_name   = "my-data-sync-bucket"
  # Optional: Configure access control for the S3 location
  access_control_rule {
    rule_type = "ACCOUNT_ID"
    # Replace with the AWS account ID of the destination account
    account_id = "123456789012"
  }
}

# Create a DataSync Task
resource "aws_datasync_task" "main" {
  name                 = "my-datasync-task"
  source_location_arn = aws_datasync_location_s3.main.arn
  # Optional: Configure the destination location
  # If you have another location created (e.g., EFS), provide its ARN here
  destination_location_arn = aws_datasync_location_s3.main.arn

  # Specify the schedule for the task
  schedule { 
    schedule_type = "MANUAL"
    # Optional: Set a schedule for automated data transfers
    # schedule_type = "CRONTIME"
    # cron_expression = "0 0 * * * ? *"
  }

  # Optional: Configure advanced options for the task
  # Exclude certain files or folders from the transfer
  # exclusion_filters = ["*.log"]
  # Configure data transfer options
  # options { 
    #  transfer_mode = "CHANGED"
  #}
}

# Create a DataSync Task Execution
resource "aws_datasync_task_execution" "main" {
  task_arn = aws_datasync_task.main.arn
  # Optional: Specify a specific file or directory to transfer
  # include_filters = ["my-data-sync-bucket/my-file.txt"]
  # Optional: Set a unique name for this task execution
  # name = "my-task-execution"
}

  