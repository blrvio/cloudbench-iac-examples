
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Crie um agente DataSync
resource "aws_datasync_agent" "agent" {
  activation_key = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  name            = "agent-example"
  tags = {
    Name = "DataSync Agent"
  }
}

# Crie uma localização de origem (Amazon S3)
resource "aws_datasync_location_s3" "source_location" {
  bucket_name = "source-bucket"
  region       = "us-east-1"
  subdirectory = "source-folder"
}

# Crie uma localização de destino (Amazon S3)
resource "aws_datasync_location_s3" "destination_location" {
  bucket_name = "destination-bucket"
  region       = "us-east-1"
  subdirectory = "destination-folder"
}

# Crie uma tarefa DataSync
resource "aws_datasync_task" "task" {
  name     = "sync-task"
  source_location_arn = aws_datasync_location_s3.source_location.arn
  destination_location_arn = aws_datasync_location_s3.destination_location.arn
  options = {
    verify_mode = "checksum"
    overwrite_mode = "overwrite"
  }
  schedule = "cron(0 0 * * ? *)"
  tags = {
    Name = "DataSync Task"
  }
}

# Crie um conjunto de exclusão para a tarefa DataSync
resource "aws_datasync_task_exclusion_rule" "exclude_rule" {
  task_arn = aws_datasync_task.task.arn
  rule      = "*.log"
}

# Crie um conjunto de inclusão para a tarefa DataSync
resource "aws_datasync_task_inclusion_rule" "include_rule" {
  task_arn = aws_datasync_task.task.arn
  rule      = "*.csv"
}
    