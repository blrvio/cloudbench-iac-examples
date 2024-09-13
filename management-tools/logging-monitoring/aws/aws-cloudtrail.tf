
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um trail
resource "aws_cloudtrail" "main" {
  name = "my-trail"
  s3_bucket_name = "my-bucket"
  s3_key_prefix  = "cloudtrail-logs"
  is_multi_region_trail = true
  enable_log_file_validation = true

  # Adicione eventos para serem logados
  event_selectors {
    read_write_type = ["All"]
  }
}

# Configure a notificação SNS
resource "aws_sns_topic" "cloudtrail_notifications" {
  name = "cloudtrail-notifications"
}

resource "aws_cloudtrail_event_selector" "notifications" {
  trail_name = aws_cloudtrail.main.name
  event_selectors {
    read_write_type = ["All"]
    data_resources  = ["aws.ec2"]
    include_management_events = true
  }
  # Define o tópico SNS para notificações
  advanced_event_selectors {
    name = "notifications"
    field = "eventSource"
    values = ["aws.ec2"]
  }
}

    