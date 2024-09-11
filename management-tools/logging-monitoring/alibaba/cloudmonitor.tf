
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  region = "cn-hangzhou" # Replace with your desired region
}

# Create a CloudMonitor alarm
resource "alicloud_cms_alarm" "main" {
  alarm_name = "MyAlarm"
  alarm_rule_id = "your_alarm_rule_id" # Replace with your existing alarm rule ID
  alarm_action = "your_alarm_action" # Replace with your desired alarm action, e.g., "Notify"
  # Configure the notification settings
  notification_config {
    receiver_types = ["Email"]
    receiver_list = ["your_email@example.com"]
  }
}

# Create a CloudMonitor alarm rule
resource "alicloud_cms_alarm_rule" "main" {
  alarm_rule_name = "MyAlarmRule"
  namespace = "acs_ecs_dashboard"
  metric_name = "CpuUtilization"
  period = 300
  statistic = "Average"
  threshold = 80
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = 1
  # Optionally define the resource group for the alarm rule
  resource_group {
    resource_group_id = "your_resource_group_id" # Replace with your resource group ID
  }
}

  