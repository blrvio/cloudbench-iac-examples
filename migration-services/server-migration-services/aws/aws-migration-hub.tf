
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um novo Migration Hub Home Region
resource "aws_migrationhub_home_region_control" "default" {
  home_region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um novo Migration Task
resource "aws_migrationhub_migration_task" "example" {
  migration_task_name = "example"
  progress_update_stream = aws_migrationhub_home_region_control.default.home_region
}

# Crie um novo Migration Task
resource "aws_migrationhub_notification_config" "default" {
  notification_event_types = ["DISCOVERY_COMPLETED", "REFACTOR_SPANS_COMPLETED", "STOP_ASSESSMENT_COMPLETE"] # Substitua pelos eventos de notificação desejados
}

    