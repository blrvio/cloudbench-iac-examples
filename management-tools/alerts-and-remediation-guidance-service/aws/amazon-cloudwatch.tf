
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a CloudWatch Log Group
resource "aws_cloudwatch_log_group" "main" {
  name              = "my-log-group" # Name of your log group
  retention_in_days = 14             # Number of days to retain log events
}

# Create a CloudWatch Log Stream
resource "aws_cloudwatch_log_stream" "main" {
  log_group_name = aws_cloudwatch_log_group.main.name
  name           = "my-log-stream" # Name of your log stream
}

# Create a CloudWatch Alarm
resource "aws_cloudwatch_alarm" "main" {
  alarm_name          = "my-alarm" # Name of your alarm
  alarm_description   = "Alarm when CPU utilization exceeds 80%"
  metric_name         = "CPUUtilization"       # Metric to monitor
  namespace           = "AWS/EC2"              # Namespace of the metric
  statistic           = "Average"              # Statistical operation to perform on the metric
  period              = 300                    # Time period in seconds over which the statistic is applied
  evaluation_periods  = 1                      # Number of periods to evaluate
  threshold           = 80                     # Threshold value
  comparison_operator = "GreaterThanThreshold" # Comparison operator
  # Specify the dimensions for the metric
  dimensions = {
    InstanceId = "i-1234567890abcdef0" # Replace with your instance ID
  }
}

# Create a CloudWatch Event Rule
resource "aws_cloudwatch_event_rule" "main" {
  name          = "my-event-rule"
  description   = "Trigger an action when an alarm is triggered"
  event_pattern = <<EOF
{
  "source": [
    "aws.ec2"
  ],
  "detail": {
    "state": [
      "ALARM"
    ]
  }
}
EOF
  # Specify the target to invoke when the rule is triggered
  # You can use a Lambda function, SNS topic, or other supported targets
  # targets {
  #   id = "my-target"
  #   arn = "arn:aws:lambda:us-east-1:123456789012:function:my-lambda-function"
  #   # Additional target-specific parameters can be specified here
  # }
}

# Create a CloudWatch Metric Filter
resource "aws_cloudwatch_metric_filter" "main" {
  filter_name    = "my-filter"
  log_group_name = aws_cloudwatch_log_group.main.name
  filter_pattern = "[field=@timestamp][time_ago(1 hour)] | filter @message like /Error/" # Filter pattern for log events
}

  