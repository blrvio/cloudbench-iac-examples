
    # Configure the IBM Cloud provider
provider "ibm" {
  region = "us-south"
}

# Create an IBM Cloud Monitoring instance
resource "ibm_monitoring_instance" "main" {
  name = "my-monitoring-instance"
  plan = "lite"

  # Optional configuration
  # region = "us-south"
  # zone = "us-south-1"
  # custom_tags = {
  #   key1 = "value1"
  #   key2 = "value2"
  # }
}

# Create a monitoring dashboard
resource "ibm_monitoring_dashboard" "main" {
  instance_id = ibm_monitoring_instance.main.id
  name = "my-dashboard"
  # Optional configuration
  # description = "This is my monitoring dashboard"
}

# Create a monitoring alert
resource "ibm_monitoring_alert" "main" {
  instance_id = ibm_monitoring_instance.main.id
  name = "my-alert"
  # Optional configuration
  # description = "This is my monitoring alert"
  # severity = "critical"
  # condition = "metric.value > 10"
  # notification_method = "email"
  # notification_recipient = "my.email@example.com"
}

  