
    # Configure the Google Cloud provider
provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Create a Stackdriver Monitoring Alert Policy
resource "google_monitoring_alert_policy" "main" {
  display_name = "My Alert Policy"
  # Define the alert condition
  condition {
    display_name = "CPU Utilization"
    condition_threshold {
      filter = "metric.type = \"compute.googleapis.com/instance/cpu/utilization\" AND resource.type = \"gce_instance\" AND resource.labels.instance_name = \"your-instance-name\""
      duration  = "600s"
      trigger {
        # Trigger the alert if CPU utilization is above 90%
        count = 1
        percent = 90
        direction = "above"
        # Trigger for 1 minute
        period = "60s"
      }
    }
  }
  # Define the notification channels
  notification_channels = ["projects/your-project-id/notificationChannels/your-channel-id"]
}

# Create a Stackdriver Logging Metric
resource "google_logging_metric" "main" {
  name         = "my-logging-metric"
  filter       = "resource.type = \"gce_instance\" AND resource.labels.instance_name = \"your-instance-name\""
  metric_filter = "logName = \"projects/your-project-id/logs/syslog\" AND severity >= ERROR"
  value_extractor = "extract(response.code, r'\d+')"
  description = "Metric for instance logs"
}

  