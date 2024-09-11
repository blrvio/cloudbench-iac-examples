
    # Configure the Alibaba Cloud Provider
provider "alicloud" {
  # Replace with your Alibaba Cloud region
  region = "cn-hangzhou"
}

# Create a Log Service Project
resource "alicloud_log_project" "default" {
  name = "my-log-service-project"
}

# Create a Log Service Store
resource "alicloud_log_store" "default" {
  project_name = alicloud_log_project.default.name
  name = "my-log-service-store"
  # Set your preferred retention period
  retention_period = 3600
  shard_count = 1
}

# Create a Log Service Logtail Configuration
resource "alicloud_log_logtail_config" "default" {
  project_name = alicloud_log_project.default.name
  store_name = alicloud_log_store.default.name
  name = "my-logtail-config"
  # Define the logtail configuration details
  input_type = "file"
  # Replace with your actual log file path
  input_path = "/var/log/nginx/access.log"
  # Replace with your actual log format
  log_format = "${timestamp} ${remote_addr} ${remote_user} ${request} ${status} ${body_bytes_sent} ${http_referer} ${http_user_agent} ${request_time}"
  # Replace with your preferred log source and target
  log_source = "nginx"
  log_target = "access_log"
}

  