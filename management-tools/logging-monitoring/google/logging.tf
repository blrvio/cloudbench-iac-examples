
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Logging sink
resource "google_logging_sink" "main" {
  name = "my-sink"
  destination = "bigquery.googleapis.com/projects/your-gcp-project-id/datasets/my_dataset/tables/my_table"
  filter     = "logName="projects/your-gcp-project-id/logs/syslog" AND severity>=ERROR"
}

# Create a Logging metric
resource "google_logging_metric" "main" {
  name = "error-count"
  filter     = "logName="projects/your-gcp-project-id/logs/syslog" AND severity>=ERROR"
  description = "Counts errors in syslog"
}

# Create a Logging alert
resource "google_logging_alert" "main" {
  name     = "error-alert"
  description = "Alert on errors in syslog"
  filter     = "logName="projects/your-gcp-project-id/logs/syslog" AND severity>=ERROR"
  criteria  = "metric.name = "error-count" AND metric.value >= 10"
  notification_channels = ["pubsub.googleapis.com/projects/your-gcp-project-id/topics/my-alert-topic"]
}
  