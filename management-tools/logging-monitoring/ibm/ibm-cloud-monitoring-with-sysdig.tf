
    # Configure the IBM Cloud Provider
provider "ibm" {
  api_key = "YOUR_IBM_CLOUD_API_KEY" # Replace with your IBM Cloud API Key
  region  = "us-south"
}

# Create a Sysdig Monitor instance
resource "ibm_sysdig_monitor_instance" "main" {
  name   = "my-sysdig-instance"
  plan   = "basic"
  region = "us-south"
}

# Create a Sysdig Monitor alert
resource "ibm_sysdig_monitor_alert" "main" {
  monitor_instance_id = ibm_sysdig_monitor_instance.main.id
  name              = "high-cpu-alert"
  description       = "Alert when CPU usage is above 90%"
  # Define the alert condition
  condition {
    metric    = "cpu"
    operator = "gt"
    threshold = 90
  }
  # Define the alert notification
  notification {
    type        = "email"
    email_config {
      email_address = "your@email.com"
    }
  }
}

  