
# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create an AWS Backup vault
resource "aws_backup_vault" "main" {
  name               = "my-backup-vault"
  encryption_key_arn = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
  # Replace with your KMS key ARN
  tags = {
    Name = "My Backup Vault"
  }
}

# Create a backup plan
resource "aws_backup_plan" "main" {
  name = "my-backup-plan"
  rule {
    rule_name         = "daily-backup"
    schedule          = "cron(0 0 * * ? *)" # Run backup daily at midnight
    target_vault_name = aws_backup_vault.main.name
    lifecycle {
      move_to_cold_storage_after_days = 30 # Move backups to cold storage after 30 days
      delete_after_days               = 60 # Delete backups after 60 days
    }
  }
  # Define the resources to be backed up
  selection {
    selection_tag {
      type  = "STRING"
      key   = "BackupEnabled"
      value = "true"
    }
  }
}

# Create a recovery point for an EC2 instance
resource "aws_backup_selection_tag" "main" {
  backup_plan_id = aws_backup_plan.main.id
  # Define the resource to be backed up by tag
  resources = ["arn:aws:ec2:us-east-1:123456789012:instance/i-1234567890abcdef0"]
  # Replace with the ARN of your EC2 instance
  selection_tag {
    type  = "STRING"
    key   = "BackupEnabled"
    value = "true"
  }
}

# You can use other AWS Backup resources to manage your backups and recovery processes
# such as aws_backup_report_plan, aws_backup_report_job, and aws_backup_framework

  