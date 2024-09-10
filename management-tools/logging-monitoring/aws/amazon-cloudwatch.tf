
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

# Create a CloudWatch Log Group
resource "aws_cloudwatch_log_group" "main" {
  name              = "my-log-group" # Name of the log group
  retention_in_days = 14             # Retention period in days (optional)
}

# Create a CloudWatch Log Stream
resource "aws_cloudwatch_log_stream" "main" {
  log_group_name = aws_cloudwatch_log_group.main.name # Name of the log group
  name           = "my-log-stream"                    # Name of the log stream
}

# Create a CloudWatch Alarm
resource "aws_cloudwatch_alarm" "main" {
  alarm_name          = "my-alarm"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  statistic           = "Average"
  period              = 60 # Period in seconds
  evaluation_periods  = 1  # Number of periods to evaluate
  threshold           = 80
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "notBreaching"

  # Define the alarm's actions
  alarm_actions = [aws_sns_topic.main.arn]
  # Define the alarm's actions
  insufficient_data_actions = [aws_sns_topic.main.arn]
}

# Create a SNS Topic
resource "aws_sns_topic" "main" {
  name = "my-sns-topic"
  # Add a subscription to the SNS topic
  # This will send notifications to the specified email address
  subscription {
    protocol = "email"
    endpoint = "your-email@example.com"
  }
}
  