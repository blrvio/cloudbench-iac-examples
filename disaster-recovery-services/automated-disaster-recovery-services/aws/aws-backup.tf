
    # Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a Backup Vault
resource "aws_backup_vault" "main" {
  name        = "my-backup-vault" # Name of the backup vault
  encryption_key_arn = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012" # KMS key to use for encryption
  # You can use the `aws_kms_key` resource to create a new KMS key
  # Example:
  # resource "aws_kms_key" "main" {
  #   description = "My KMS key"
  #   enable_key_rotation = true
  # }
}

# Create a Backup Plan
resource "aws_backup_plan" "main" {
  name = "my-backup-plan" # Name of the backup plan
  rule {
    rule_name = "daily-backup" # Name of the backup rule
    schedule  = "cron(0 0 * * ? *)" # Schedule for the backup
    target {
      name = "ec2-instance-backup" # Name of the backup target
      # Backup the specified EC2 instance
      resource_type = "AWS::EC2::Instance"
      resource_arn  = "arn:aws:ec2:us-east-1:123456789012:instance/i-1234567890abcdef0" # ARN of the EC2 instance
    }
  }
  # Add tags to the backup plan
  tags = {
    Name = "My Backup Plan"
  }
}

# Create a Backup Selection
resource "aws_backup_selection" "main" {
  backup_plan_id = aws_backup_plan.main.id # ID of the backup plan
  selection_name = "my-backup-selection" # Name of the backup selection
  # Include the specified resources in the backup
  iam_role_arn = "arn:aws:iam::123456789012:role/backup-role" # IAM role to allow Backup to access the resources
  resources = ["arn:aws:ec2:us-east-1:123456789012:instance/i-1234567890abcdef0"]
  # Add tags to the backup selection
  tags = {
    Name = "My Backup Selection"
  }
}
  