
    # Configure the Oracle Cloud provider
provider "oci" {
  # Replace with your specific values
  region = "us-ashburn-1"
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaz77777777777777777777777777"
  user_ocid = "ocid1.user.oc1..aaaaaaaaz77777777777777777777777777"
  fingerprint = "..."
  private_key_path = "~/.oci/oci_api_key.pem"
}

# Create a Cloud Guard detector
resource "oci_cloud_guard_detector" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz77777777777777777777777777"
  display_name = "My Detector"
  # Define the detector type
  detector_type = "PREVENTIVE"
  # Define the detector configuration
  detector_config {
    # Define the rules to apply to the detector
    rules {
      # Define the rule configuration
      rule_config {
        # Define the rule type
        rule_type = "COMPLIANCE"
        # Define the rule criteria
        criteria {
          # Define the resource type
          resource_type = "oci.core.Instance"
          # Define the resource attribute to check
          attribute = "security_list_ids"
          # Define the operator to use
          operator = "NOT_IN"
          # Define the values to compare
          values = ["ocid1.securitylist.oc1..aaaaaaaaz77777777777777777777777777", "ocid1.securitylist.oc1..bbbbbbbbz77777777777777777777777777"]
        }
      }
    }
  }
}

# Create a Cloud Guard target
resource "oci_cloud_guard_target" "example" {
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaz77777777777777777777777777"
  display_name = "My Target"
  # Define the target type
  target_type = "RESOURCE"
  # Define the resource to apply the detector to
  resource {
    # Define the resource type
    resource_type = "oci.core.Instance"
    # Define the resource OCID
    resource_id = "ocid1.instance.oc1..aaaaaaaaz77777777777777777777777777"
  }
  # Define the detector to apply to the target
  detector_id = oci_cloud_guard_detector.example.id
}

  