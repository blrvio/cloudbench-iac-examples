
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a SWF Domain
resource "aws_swf_domain" "main" {
  name = "my-swf-domain"
  # Define the configuration for the SWF domain
  configuration {
    workflow_execution_retention_period_in_days = 30 # Set the retention period for workflow executions in days
  }
}

# Create a SWF Workflow Type
resource "aws_swf_workflow_type" "main" {
  domain = aws_swf_domain.main.name
  name = "my-workflow-type"
  version = "1.0"
  # Define the configuration for the workflow type
  configuration {
    default_task_list = "my-task-list"
    default_child_policy = "TERMINATE"
    execution_start_to_close_timeout = 300 # Set the timeout for the workflow execution
  }
}

# Create a SWF Activity Type
resource "aws_swf_activity_type" "main" {
  domain = aws_swf_domain.main.name
  name = "my-activity-type"
  version = "1.0"
  # Define the configuration for the activity type
  configuration {
    default_task_list = "my-task-list"
    schedule_to_close_timeout = 60 # Set the timeout for scheduling and closing the activity
    schedule_to_start_timeout = 60 # Set the timeout for scheduling and starting the activity
    heartbeat_timeout = 30 # Set the timeout for the activity heartbeat
    task_list = "my-task-list"
    task_priority = "0"
  }
}

# Create a SWF Decision Task List
resource "aws_swf_task_list" "main" {
  name = "my-task-list"
  domain = aws_swf_domain.main.name
  # Optional: Create a sticky task list
  # sticky = true
}

  