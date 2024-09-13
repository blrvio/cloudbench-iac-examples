
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um alarme do CloudWatch para monitorar a CPU de uma instância EC2
resource "aws_cloudwatch_alarm" "cpu_utilization_alarm" {
  alarm_name          = "CPUUtilizationAlarm"
  alarm_description   = "Alarme para CPU acima de 80%"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 1
  threshold           = 80
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    InstanceId = aws_instance.web_server.id
  }
}

# Crie um log group para armazenar logs do CloudWatch
resource "aws_cloudwatch_log_group" "my_log_group" {
  name = "my_log_group"
}

# Crie um log stream para enviar logs para o log group
resource "aws_cloudwatch_log_stream" "my_log_stream" {
  log_group_name = aws_cloudwatch_log_group.my_log_group.name
  name            = "my_log_stream"
}

# Crie um recurso para definir a política de retenção de logs
resource "aws_cloudwatch_log_retention_policy" "my_retention_policy" {
  log_group_name = aws_cloudwatch_log_group.my_log_group.name
  retention_in_days = 14
}
    