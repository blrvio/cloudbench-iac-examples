
    # Configure the Alibaba Cloud provider
provider "alicloud" {
  # Replace with your Alibaba Cloud region
  region = "us-east-1"
  # Replace with your Alibaba Cloud access key ID
  access_key = "YOUR_ACCESS_KEY_ID"
  # Replace with your Alibaba Cloud access key secret
  secret_key = "YOUR_ACCESS_KEY_SECRET"
}

# Create an ARMS Application
resource "alicloud_arms_application" "main" {
  # Replace with your application name
  name = "my-application"
  # Replace with your application description
  description = "My ARMS Application"
  # Replace with your application type (eg. web, app)
  type = "web"
  # Replace with your application region
  region = "us-east-1"
  # Replace with your application group ID
  group_id = "your_group_id"
  # Replace with your application cluster ID
  cluster_id = "your_cluster_id"
  # Replace with your application version
  version = "1.0.0"
}

# Create an ARMS Alert Rule
resource "alicloud_arms_alert_rule" "main" {
  # Replace with your alert rule name
  name = "my-alert-rule"
  # Replace with your alert rule description
  description = "My ARMS Alert Rule"
  # Replace with your alert rule metric name
  metric_name = "CPUUtilization"
  # Replace with your alert rule namespace
  namespace = "System/CPU"
  # Replace with your alert rule trigger threshold
  trigger_threshold = 80
  # Replace with your alert rule trigger type
  trigger_type = "GREATER_THAN"
  # Replace with your alert rule duration
  duration = 60
  # Replace with your alert rule severity
  severity = "INFO"
  # Replace with your alert rule actions
  actions = ["ALERT", "SEND_EMAIL"]
  # Replace with your alert rule application ID
  application_id = alicloud_arms_application.main.id
}

# Create an ARMS Alert Contact
resource "alicloud_arms_alert_contact" "main" {
  # Replace with your alert contact name
  name = "my-alert-contact"
  # Replace with your alert contact description
  description = "My ARMS Alert Contact"
  # Replace with your alert contact email
  email = "your@email.com"
  # Replace with your alert contact phone number
  phone = "your_phone_number"
}

  