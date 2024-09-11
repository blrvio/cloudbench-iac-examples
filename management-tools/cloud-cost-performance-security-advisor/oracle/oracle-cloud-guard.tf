
    # Configure the Oracle Cloud provider
provider "oci" {
  # Replace with your Oracle Cloud tenancy information
  region     = "us-ashburn-1"
  tenancy_id = "ocid1.tenancy.oc1..aaaaaaaaaayyy78765"
  user       = "your_username"
  password   = "your_password"
}

# Create a Cloud Guard detector
resource "oci_cloud_guard_detector" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaaaayyy78765"
  display_name  = "My Cloud Guard Detector"
  # Define the detector type
  detector_type = "PREVENTIVE"
  # Configure the detector's rules
  rules {
    # Add your desired Cloud Guard rules here
    # For example:
    # rule_name = "My Custom Rule"
    # description = "This rule checks for open ports on public subnets"
    # rule_type = "PORT_SCANNING"
    # enabled = true
    # actions = ["ALERT"]
  }
  # Configure the detector's actions
  actions {
    # Add your desired actions here
    # For example:
    # action_type = "ALERT"
    # notification_details {
    #   # Specify the notification details
    # }
  }
}

  