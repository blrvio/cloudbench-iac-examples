
      # Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a DMS replication instance
resource "aws_dms_replication_instance" "default" {
  replication_instance_class = "dms.t2.small"
  replication_instance_identifier = "dms-replication-instance"
  engine_version = "1.2.0"

  # Additional configuration options...
}

# Create a DMS replication task
resource "aws_dms_replication_task" "default" {
  replication_task_identifier = "dms-replication-task"
  replication_instance_arn = aws_dms_replication_instance.default.replication_instance_arn
  source_endpoint_arn = aws_dms_endpoint.source.endpoint_arn
  target_endpoint_arn = aws_dms_endpoint.target.endpoint_arn

  # Additional configuration options...
}

# Create a DMS endpoint for the source database
resource "aws_dms_endpoint" "source" {
  endpoint_id = "dms-source-endpoint"
  endpoint_type = "source"
  engine_name = "mysql"
  username = "username"
  password = "password"
  hostname = "hostname"
  port = 3306

  # Additional configuration options...
}

# Create a DMS endpoint for the target database
resource "aws_dms_endpoint" "target" {
  endpoint_id = "dms-target-endpoint"
  endpoint_type = "target"
  engine_name = "postgres"
  username = "username"
  password = "password"
  hostname = "hostname"
  port = 5432

  # Additional configuration options...
}

    