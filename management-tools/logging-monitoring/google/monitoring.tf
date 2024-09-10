
    # Configure the Google Cloud provider
provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a Cloud Monitoring Workspace
resource "google_monitoring_workspace" "main" {
  name = "my-monitoring-workspace"
}

# Create an Uptime Check
resource "google_monitoring_uptime_check_config" "main" {
  display_name = "my-uptime-check"
  # Define the monitored resource
  monitored_resource  = "global"
  # Define the check type
  check_interval_seconds = 60
  timeout_seconds        = 10
  # Configure the HTTP/HTTPS check
  http_check {
    path         = "/"
    port         = 80
    use_ssl      = false
    validate_ssl = false
  }
}

  