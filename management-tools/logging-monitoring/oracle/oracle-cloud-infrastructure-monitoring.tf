
    # Configure the Oracle Cloud Infrastructure Provider
provider "oci" {
  region = "us-ashburn-1"
  # Replace with your Oracle Cloud Infrastructure tenancy OCID
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaxxxxyyy"
  # Replace with your Oracle Cloud Infrastructure user OCID
  user_ocid = "ocid1.user.oc1..aaaaaaaaxxxxyyy"
  # Replace with your Oracle Cloud Infrastructure API key
  api_key = "xxxxxxxxxxxxxxxxxxxxx"
}

# Define an Oracle Cloud Infrastructure Monitoring Alert Rule
resource "oci_monitoring_alert_rule" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaxxxxyyy"
  # Replace with the name of your alert rule
  display_name = "MyAlertRule"
  description = "Example Alert Rule"
  # Define the alert rule's configuration
  alert_rule_config {
    # Define the alert rule's condition
    condition {
      # Replace with the desired metric
      metric_name = "CpuUtilization"
      # Replace with the desired aggregation type
      aggregation_type = "AVERAGE"
      # Replace with the desired aggregation window
      aggregation_window = "PT5M"
      # Replace with the desired comparison operator
      comparison_operator = "GREATER_THAN"
      # Replace with the desired threshold
      threshold = 90
      # Replace with the desired evaluation period
      evaluation_periods = 3
    }
    # Define the alert rule's actions
    actions {
      # Define a notification action
      notification_actions {
        # Replace with the desired notification action's configuration
      }
      # Define an automation action
      automation_actions {
        # Replace with the desired automation action's configuration
      }
    }
  }
}

  