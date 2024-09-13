
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um plano de backup
resource "aws_backup_plan" "example" {
  name = "example-backup-plan"
}

# Crie uma regra de backup
resource "aws_backup_rule" "example" {
  backup_plan_id = aws_backup_plan.example.id
  rule_name       = "example-backup-rule"
  schedule         = "cron(0 0 * * ? *)"
  target_vault_name = "example-vault"
}

# Crie um cofre de backup
resource "aws_backup_vault" "example" {
  name = "example-vault"
}
    