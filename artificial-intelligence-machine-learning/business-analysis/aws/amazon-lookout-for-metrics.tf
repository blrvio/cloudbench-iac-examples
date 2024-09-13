
      # Configure o provedor do AWS
provider "aws" {
  region = "us-east-1" # Substitua pela sua região desejada
}

# Crie um AnomaliaDetector
resource "aws_lookoutmetrics_anomaly_detector" "my_detector" {
  anomaly_detector_config {
    metric_set_config {
      metric_set_name = "MyMetricSet"
      metric_list {
        metric_name = "CPUUtilization"
        namespace   = "AWS/EC2"
        statistic    = "Average"
        dimensions {
          name  = "InstanceId"
          value = "i-xxxxxxxx" # Substitua pelo ID da instância
        }
      }
    }
  }
  kms_key_arn = "arn:aws:kms:us-east-1:123456789012:key/xxxxxxxxxxxxxxxxxxxxxxxxxxxxx" # Substitua pela chave KMS
  name = "MyAnomalyDetector"
  tags = {
    Name = "My Anomaly Detector"
  }
}

# Crie um Alerta
resource "aws_lookoutmetrics_alert" "my_alert" {
  anomaly_detector_arn = aws_lookoutmetrics_anomaly_detector.my_detector.arn
  alert_name         = "MyAlert"
  alert_description = "Alerta para anomalias no CPUUtilization"
  alert_action {
    action_type = "sns"
    sns_config {
      sns_topic_arn = "arn:aws:sns:us-east-1:123456789012:my-topic" # Substitua pelo ARN do tópico SNS
    }
  }
  alert_filter {
    metric_set_name  = "MyMetricSet"
    anomaly_severity = "MEDIUM"
  }
}
    