
      # Configure o provedor AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um namespace personalizado para métricas
resource "aws_cloudwatch_namespace" "my_namespace" {
  name = "MyCustomNamespace"
}

# Crie uma métrica personalizada
resource "aws_cloudwatch_metric" "my_metric" {
  namespace = aws_cloudwatch_namespace.my_namespace.name
  metric_name = "MyCustomMetric"
  dimensions = {
    Application = "MyApp"
  }
}

# Crie um alarme para monitorar a métrica
resource "aws_cloudwatch_alarm" "my_alarm" {
  alarm_name          = "MyCustomAlarm"
  metric_name        = aws_cloudwatch_metric.my_metric.metric_name
  namespace           = aws_cloudwatch_namespace.my_namespace.name
  statistic           = "Sum"
  period              = 60
  evaluation_periods  = 1
  threshold           = 10
  comparison_operator = "GreaterThanThreshold"
}

# Crie um dashboard para visualizar as métricas
resource "aws_cloudwatch_dashboard" "my_dashboard" {
  dashboard_name = "MyCustomDashboard"
  dashboard_body = <<DASHBOARD_BODY
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 6,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "CPUUtilization",
            "{InstanceId}"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "CPU Utilization"
      }
    }
  ]
}
DASHBOARD_BODY
}

    