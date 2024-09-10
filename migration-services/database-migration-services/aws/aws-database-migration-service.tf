
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a DMS Replication Task
resource "aws_dms_replication_task" "main" {
  replication_task_identifier = "my-replication-task"
  source_endpoint_arn          = aws_dms_endpoint.source.arn
  target_endpoint_arn          = aws_dms_endpoint.target.arn
  migration_type               = "full-load"
  # Optional configurations
  replication_task_settings = <<EOF
# Customize your replication settings
EOF
}

# Create a DMS Source Endpoint
resource "aws_dms_endpoint" "source" {
  endpoint_id = "source-endpoint"
  endpoint_type = "mysql"
  # Configure the MySQL source endpoint
  mysql_settings {
    server_name     = "source-db-instance.example.com"
    port           = 3306
    database_name   = "source-database"
    username       = "source-username"
    password       = "source-password"
  }
}

# Create a DMS Target Endpoint
resource "aws_dms_endpoint" "target" {
  endpoint_id = "target-endpoint"
  endpoint_type = "postgresql"
  # Configure the PostgreSQL target endpoint
  postgresql_settings {
    server_name     = "target-db-instance.example.com"
    port           = 5432
    database_name   = "target-database"
    username       = "target-username"
    password       = "target-password"
  }
}

# Start the DMS Replication Task
resource "aws_dms_replication_task_assessment_run" "main" {
  replication_task_arn = aws_dms_replication_task.main.arn
  # Optional configurations
  assessment_run_name   = "my-assessment-run"
  assessment_run_mode = "validation"
}

  